# Ref: https://docs.pytest.org/en/latest/fixture.html#conftest-py-sharing-fixture-functions
import json
import os

import pytest

from naver_oauth.login import invoke_logout, invoke_login


@pytest.fixture
def username():
    with open(os.path.join(
            os.path.dirname(__file__),
            "oss-test-credentials.json"
    ), "r") as f:
        credentaials = json.load(f)

    return credentaials["username"]


@pytest.fixture
def password():
    with open(os.path.join(
            os.path.dirname(__file__),
            "oss-test-credentials.json"
    ), "r") as f:
        credentaials = json.load(f)

    return credentaials["password"]


@pytest.fixture
def email():
    with open(os.path.join(
            os.path.dirname(__file__),
            "oss-test-credentials.json"
    ), "r") as f:
        credentaials = json.load(f)

    return credentaials["email"]


@pytest.fixture
def login(request, username, password):
    invoke_logout()
    invoke_login(username, password)

    def fin():
        invoke_logout()

    request.addfinalizer(fin)
    return None
