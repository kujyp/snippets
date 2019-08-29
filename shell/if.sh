#!/usr/bin/env bash

#cuda_version="8.0" # true
#cuda_version="9.0" # true
#cuda_version="9.2" # false
#cuda_version="10.0" # false
if [[ ${cuda_version} -eq "8.0" ]] || [[ ${cuda_version} -eq "9.0" ]]; then
    echo true
else
    echo false
fi


#cuda_version="8.0" # false
#cuda_version="9.0" # true
#cuda_version="9.2" # true
#cuda_version="10.0" # true
if ! [[ ${cuda_version} -eq "8.0" ]] || [[ ${cuda_version} -eq "9.0" ]]; then
    echo true
else
    echo false
fi


#cuda_version="8.0" # false
#cuda_version="9.0" # false
#cuda_version="9.2" # true
#cuda_version="10.0" # true
if ! [[ ${cuda_version} -eq "8.0" ]] && ! [[ ${cuda_version} -eq "9.0" ]]; then
    echo true
else
    echo false
fi

#cuda_version="8.0" # false
#cuda_version="9.0" # false
#cuda_version="9.2" # true
cuda_version="10.0" # true
if [[ ${cuda_version} -ne "8.0" ]] && [[ ${cuda_version} -ne "9.0" ]]; then
    echo true
else
    echo false
fi

# sh shell error
# sh: [[: 10.0: syntax error: invalid arithmetic operator (error token is ".0")
#cuda_version="8.0" # false
#cuda_version="9.0" # false
#cuda_version="9.2" # true
#cuda_version="10.0" # true
if [[ ${cuda_version} != "8.0" ]] && [[ ${cuda_version} != "9.0" ]]; then
    echo true
else
    echo false
fi
