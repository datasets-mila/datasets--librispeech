#!/bin/bash

source scripts/utils.sh echo -n

function activate_gitannex {
	_conda_env=$(git config --file scripts/config/datalad_config --get datalad.conda.conda-env || echo -n)
	if [[ ! -z "${_conda_env}" ]]
	then
		_modules=$(git config --file scripts/config/datalad_config --get datalad.conda.modules || echo -n)
		if [[ -z "$(which conda)" ]] && [[ ! -z "${_modules}" ]]
		then
			module load ${_modules}
		fi
		conda activate ${_conda_env}
	fi
}

function install_datalad {
	init_venv --name venv --prefix .tmp/
	exit_on_error_code "Failed to init venv"

	datalad --version >/dev/null 2>&1 || python3 -m pip install -r scripts/requirements_datalad.txt
	exit_on_error_code "Failed to install datalad requirements: pip install"
}

which git-annex || activate_gitannex
datalad --version >/dev/null 2>&1 || install_datalad
exit_on_error_code "Failed to install datalad requirements: pip install"
datalad "$@"
