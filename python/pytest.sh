#!/usr/bin/env bash

PYTHONPATH='.' pytest -vs tests --junitxml test-reports/pytest_junit.xml
