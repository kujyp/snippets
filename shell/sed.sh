
# sed for MacOS
sed -i '' "s/^__version__.*/__version__ = '0.0.0'/" mtrobust/about.py
# sed for Linux
sed -i "s/^__version__.*/__version__ = '0.0.0'/" mtrobust/about.py
cat mtrobust/about.py

sed -i "s/cd-jenkins:80/35.243.115.38/" jenkins.model.JenkinsLocationConfiguration.xml


# shell phonenumber validation
# Ref: https://stackoverflow.com/questions/21112707/check-if-a-string-matches-a-regex-in-bash-script
# Ref2: https://soooprmx.com/archives/7718
docker run -it --rm centos:7
function isPhoneNumberThenEchoYes() {
    if [[ "${1-}" =~ ^([0-9]{2}|[0-9]{3})(-| )?([0-9]{3}|[0-9]{4})(-| )?[0-9]{4}$ ]]; then
        echo yes
    else
        echo no
    fi
}

isPhoneNumberThenEchoYes "0"
isPhoneNumberThenEchoYes "a"

isPhoneNumberThenEchoYes "01012345678"
isPhoneNumberThenEchoYes "010-1234-5678"
isPhoneNumberThenEchoYes "010-12345678"
isPhoneNumberThenEchoYes "010 1234 5678"
isPhoneNumberThenEchoYes "010 123 5678"
isPhoneNumberThenEchoYes "02 123 5678"
isPhoneNumberThenEchoYes "02 1234 5678"
isPhoneNumberThenEchoYes "aa1234 5678"

if [[ -z $(echo "010-1234-5678" | sed -nr 's/^([0-9]{2}|[0-9]{3})(-| )?([0-9]{3}|[0-9]{4})(-| )?[0-9]{4}$//g') ]]; then echo yes; else echo no; fi
if [[ -z $(echo "010-1234-5678" | sed -nr 's/^([0-9]{2}|[0-9]{3})(-| )?([0-9]{3}|[0-9]{4})(-| )?[0-9]{4}$//g') ]]; then echo yes; else echo no; fi
