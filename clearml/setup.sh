#!/bin/bash
echo "Running setup script."

# install poetry
# pip3 install poetry
source /root/miniconda3/envs/safe-control-gym-env/bin/python

# go to the repo directory
cd $CLEARML_GIT_ROOT

# to prevent poetry hiccups during installation
# poetry config installer.max-workers 10

# we will use poetry to install in the system python, for simplicity
# this way we can pick up preinstalled packages in a docker image
# poetry config virtualenvs.create false

# now we need to tell clearml to use the python from our poetry env
# this is in the general case (we use the system python above, so we could
# have just hardcoded this as well)
export python_path="/root/miniconda3/envs/safe-control-gym-env/bin/python"
echo "Detected python: $python_path"
cat > $CLEARML_CUSTOM_BUILD_OUTPUT << EOL
{
  "binary": "$python_path",
  "entry_point": "$CLEARML_GIT_ROOT/$CLEARML_TASK_SCRIPT_ENTRY",
  "working_dir": "$CLEARML_GIT_ROOT/$CLEARML_TASK_WORKING_DIR"
}
EOL
