import atexit
import os
import threading

import pytest

from tests import fileio_utils, download_utils
import py.path
# server Fixture
from tests.fixture_server import servers_url


FREESTORAGE_BUFFER_IN_GIGABYTES = 1.0


class AssetFile(object):
    def __init__(self, filepath, endpoint) -> None:
        super().__init__()
        self.filepath = filepath
        self.endpoint = endpoint


def get_freestorage_in_gigabyte(path):
    s = os.statvfs(path)
    freesize_in_gigabyte = s.f_bavail * s.f_frsize / 1024 / 1024 / 1024
    return freesize_in_gigabyte


@pytest.fixture(scope="module")
def asset_path():
    return "tests/assets"


@pytest.fixture(scope="function")
def download_path(temp_path):
    return temp_path


@pytest.fixture(scope="function")
def temp_path(tmpdir):
    def _finalizer():
        print("Remove [{}]...".format(tmpdir.realpath()))
        tmpdir.remove()
        print("Remove [{}]...done".format(tmpdir.realpath()))
    atexit.register(_finalizer)
    return tmpdir


def check_required_freestoreage(required_in_gigabyte, path):
    freestorage_in_gigabyte = get_freestorage_in_gigabyte(path)
    if freestorage_in_gigabyte <= required_in_gigabyte:
        pytest.skip("Free disk storage is not enough. Current free storage [{}]GB, [{}]GB required.".format(freestorage_in_gigabyte, required_in_gigabyte))


@pytest.fixture(
    scope="module",
    params=[1, 4, 10]
    # params=[0.1]
)
def bigfiles(request, asset_path):
    filesize_in_gigabyte = request.param

    required_in_gigabyte = filesize_in_gigabyte * 2 + FREESTORAGE_BUFFER_IN_GIGABYTES
    check_required_freestoreage(required_in_gigabyte, asset_path)

    file_relpath = "bigfile_list_{}gb".format(filesize_in_gigabyte)
    filepath = os.path.join(asset_path, file_relpath)

    fileio_utils.generate_file(filepath, filesize_in_gigabyte * 1024)

    finalizer = fileio_utils.get_filedeletion_finalizer_with_path(filepath)
    request.addfinalizer(finalizer)
    atexit.register(finalizer)

    return AssetFile(filepath, file_relpath)


@pytest.fixture(scope="module")
def bigfile_1gb(request, asset_path):
    filesize_in_gigabyte = 1

    required_in_gigabyte = filesize_in_gigabyte * 2 + FREESTORAGE_BUFFER_IN_GIGABYTES
    check_required_freestoreage(required_in_gigabyte, asset_path)

    file_relpath = "single_bigfile_{}gb".format(filesize_in_gigabyte)
    filepath = os.path.join(asset_path, file_relpath)

    fileio_utils.generate_file(filepath, filesize_in_gigabyte * 1024)

    finalizer = fileio_utils.get_filedeletion_finalizer_with_path(filepath)
    request.addfinalizer(finalizer)
    atexit.register(finalizer)

    return AssetFile(filepath, file_relpath)


@pytest.fixture(scope="module")
def bigfile_4gb(request, asset_path):
    filesize_in_gigabyte = 4

    required_in_gigabyte = filesize_in_gigabyte * 2 + FREESTORAGE_BUFFER_IN_GIGABYTES
    check_required_freestoreage(required_in_gigabyte, asset_path)

    file_relpath = "single_bigfile_{}gb".format(filesize_in_gigabyte)
    filepath = os.path.join(asset_path, file_relpath)

    fileio_utils.generate_file(filepath, filesize_in_gigabyte * 1024)

    finalizer = fileio_utils.get_filedeletion_finalizer_with_path(filepath)
    request.addfinalizer(finalizer)
    atexit.register(finalizer)

    return AssetFile(filepath, file_relpath)


@pytest.fixture(scope="function")
def upload_bigfile_0_1gb(request, temp_path, asset_path):
    filesize_in_gigabyte = 0.1

    required_in_gigabyte = filesize_in_gigabyte * 2 + FREESTORAGE_BUFFER_IN_GIGABYTES
    check_required_freestoreage(required_in_gigabyte, asset_path)

    upload_filepath = temp_path.join("upload_bigfile_{}gb".format(filesize_in_gigabyte))

    fileio_utils.generate_file(upload_filepath, filesize_in_gigabyte * 1024)

    def finalizer():
        if upload_filepath.exists():
            upload_filepath.remove()

    request.addfinalizer(finalizer)
    atexit.register(finalizer)

    return upload_filepath


@pytest.fixture(scope="function")
def upload_bigfile_1gb(request, temp_path, asset_path):
    filesize_in_gigabyte = 1
    required_in_gigabyte = filesize_in_gigabyte * 2 + FREESTORAGE_BUFFER_IN_GIGABYTES
    check_required_freestoreage(required_in_gigabyte, asset_path)

    upload_filepath = temp_path.join("upload_bigfile_{}gb".format(filesize_in_gigabyte))

    fileio_utils.generate_file(upload_filepath, filesize_in_gigabyte * 1024)

    def finalizer():
        if upload_filepath.exists():
            upload_filepath.remove()

    request.addfinalizer(finalizer)
    atexit.register(finalizer)

    return upload_filepath


@pytest.fixture(scope="function")
def upload_bigfile_4gb(request, temp_path, asset_path):
    filesize_in_gigabyte = 4
    required_in_gigabyte = filesize_in_gigabyte * 2 + FREESTORAGE_BUFFER_IN_GIGABYTES
    check_required_freestoreage(required_in_gigabyte, asset_path)

    upload_filepath = temp_path.join("upload_bigfile_{}gb".format(filesize_in_gigabyte))

    fileio_utils.generate_file(upload_filepath, filesize_in_gigabyte * 1024)

    def finalizer():
        if upload_filepath.exists():
            upload_filepath.remove()

    request.addfinalizer(finalizer)
    atexit.register(finalizer)

    return upload_filepath


@pytest.fixture(scope="function")
def upload_bigfile_60gb(request, temp_path, asset_path):
    filesize_in_gigabyte = 60
    required_in_gigabyte = filesize_in_gigabyte * 2 + FREESTORAGE_BUFFER_IN_GIGABYTES
    check_required_freestoreage(required_in_gigabyte, asset_path)

    upload_filepath = temp_path.join("upload_bigfile_{}gb".format(filesize_in_gigabyte))

    fileio_utils.generate_file(upload_filepath, filesize_in_gigabyte * 1024)

    def finalizer():
        if upload_filepath.exists():
            upload_filepath.remove()

    request.addfinalizer(finalizer)
    atexit.register(finalizer)

    return upload_filepath


@pytest.fixture(scope="module")
def bigfile_1_1gb(request, asset_path):
    filesize_in_gigabyte = 1.1
    required_in_gigabyte = filesize_in_gigabyte * 2 + FREESTORAGE_BUFFER_IN_GIGABYTES
    check_required_freestoreage(required_in_gigabyte, asset_path)

    file_relpath = "single_bigfile_{}gb".format(filesize_in_gigabyte)
    filepath = os.path.join(asset_path, file_relpath)

    fileio_utils.generate_file(filepath, filesize_in_gigabyte * 1024)

    finalizer = fileio_utils.get_filedeletion_finalizer_with_path(filepath)
    request.addfinalizer(finalizer)
    atexit.register(finalizer)

    return AssetFile(filepath, file_relpath)


def test_download_bigfiles(request, bigfiles, servers_url, download_path):
    url = "{}/{}".format(servers_url, bigfiles.endpoint)

    filename = os.path.basename(bigfiles.endpoint)
    download_file_path = download_path.join(filename)
    download_utils.download_url(url, download_file_path)

    request.addfinalizer(download_file_path.remove)

    assert download_file_path.exists()
    assert download_file_path.size() > 0


def test_download_1_1gfile_with_limit_rate(request, bigfile_1_1gb, servers_url, download_path):
    url = "{}/{}".format(servers_url, bigfile_1_1gb.endpoint)

    filename = os.path.basename(bigfile_1_1gb.endpoint)
    download_file_path = download_path.join(filename)

    download_utils.download_url_with_limit_rate(url, download_file_path)

    request.addfinalizer(download_file_path.remove)

    assert download_file_path.exists()
    assert download_file_path.size() == py.path.local(bigfile_1_1gb.filepath).size()


def test_benchmark_download_with_1gbfile(bigfile_1gb, servers_url, download_path, benchmark):
    url = "{}/{}".format(servers_url, bigfile_1gb.endpoint)

    filename = os.path.basename(bigfile_1gb.endpoint)
    download_file_path = download_path.join(filename)

    benchmark(download_utils.download_url_and_remove, url, download_file_path)


@pytest.mark.benchmark(
    warmup=True,
)
def test_benchmark_upload_with_0_1gbfile(request, upload_bigfile_0_1gb, servers_url, asset_path, benchmark):
    def upload():
        testname = request.node.name

        filename = os.path.basename(upload_bigfile_0_1gb)
        url = "{}/{}".format(servers_url, testname)

        uploaded_dirpath_on_server = py.path.local(asset_path).join(testname)
        if uploaded_dirpath_on_server.exists():
            uploaded_dirpath_on_server.remove()

        uploaded_filepath_on_server = uploaded_dirpath_on_server.join(filename)
        download_utils.upload_url_and_remove(url, upload_bigfile_0_1gb, uploaded_filepath_on_server)

    benchmark.pedantic(upload, rounds=20, warmup_rounds=5)


def test_upload_smallfile(upload_bigfile_0_1gb, request, servers_url, asset_path):
    testname = request.node.name

    filename = os.path.basename(upload_bigfile_0_1gb)
    url = "{}/{}".format(servers_url, testname)

    uploaded_dirpath_on_server = py.path.local(asset_path).join(testname)
    if uploaded_dirpath_on_server.exists():
        uploaded_dirpath_on_server.remove()

    uploaded_filepath_on_server = uploaded_dirpath_on_server.join(filename)
    download_utils.upload_url(url, upload_bigfile_0_1gb)

    request.addfinalizer(uploaded_dirpath_on_server.remove)

    assert uploaded_filepath_on_server.exists()
    assert uploaded_filepath_on_server.size() == upload_bigfile_0_1gb.size()


def test_upload_bigfile(upload_bigfile_60gb, request, servers_url, asset_path):
    testname = request.node.name

    filename = os.path.basename(upload_bigfile_60gb)
    url = "{}/{}".format(servers_url, testname)

    uploaded_dirpath_on_server = py.path.local(asset_path).join(testname)
    if uploaded_dirpath_on_server.exists():
        uploaded_dirpath_on_server.remove()

    uploaded_filepath_on_server = uploaded_dirpath_on_server.join(filename)
    download_utils.upload_url_with_curl(url, upload_bigfile_60gb)

    request.addfinalizer(uploaded_dirpath_on_server.remove)

    assert uploaded_filepath_on_server.exists()
    assert uploaded_filepath_on_server.size() == upload_bigfile_60gb.size()


def test_download_with_uploading(request, bigfile_4gb, upload_bigfile_4gb, servers_url, download_path, asset_path):
    testname = request.node.name

    upload_filename = os.path.basename(upload_bigfile_4gb)
    upload_url = "{}/{}".format(servers_url, testname)

    uploaded_dirpath_on_server = py.path.local(asset_path).join(testname)
    if uploaded_dirpath_on_server.exists():
        uploaded_dirpath_on_server.remove()

    uploaded_filepath_on_server = uploaded_dirpath_on_server.join(upload_filename)
    request.addfinalizer(uploaded_dirpath_on_server.remove)
    upload_thread = threading.Thread(target=download_utils.upload_url, args=(upload_url, upload_bigfile_4gb))

    download_url = "{}/{}".format(servers_url, bigfile_4gb.endpoint)
    download_filename = os.path.basename(bigfile_4gb.endpoint)
    download_file_path = download_path.join(download_filename)
    download_thread = threading.Thread(target=download_utils.download_url, args=(download_url, download_file_path))
    request.addfinalizer(download_file_path.remove)

    upload_thread.start()
    download_thread.start()
    download_thread.join()
    upload_thread.join()

    assert uploaded_filepath_on_server.exists()
    assert uploaded_filepath_on_server.size() == upload_bigfile_4gb.size()
    assert download_file_path.exists()
    assert download_file_path.size() == py.path.local(bigfile_4gb.filepath).size()
