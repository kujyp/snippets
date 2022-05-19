# pyenv 설치
curl https://pyenv.run | bash

# vi ~/.bashrc
# bashrc 에 설치시 나온 명령어 복붙
# 터미널 다시들어오기(bashrc 스크립트 다시 실행할 아무방법이나)

# 원하는 버전대 patch 버전 최신확인 3.8 설치하고싶으면 3.8.13 이 최신인것을 위 명령어로 확인
pyenv install -l

# dependencies libssl 은 필수고 나머진 optional
apt install -y libssl-dev libreadline-dev libsqlite3-dev libbz2-dev

pyenv install 3.8.13

# 평소 환경에서 3.8.13 을 메인으로 쓰려면 아래 명령어 해놓으면 편함
pyenv global 3.8.13
