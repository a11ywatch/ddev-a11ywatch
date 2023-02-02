setup() {
  set -eu -o pipefail
  export DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/.."
  export TESTDIR=~/tmp/test-ddev-a11ywatch-standalone
  mkdir -p $TESTDIR
  export PROJNAME=test-ddev-a11ywatch-standalone
  export DDEV_NON_INTERACTIVE=true
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1 || true
  cd "${TESTDIR}"
  ddev config --project-name=${PROJNAME}
  ddev start -y >/dev/null
}

teardown() {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  ddev delete -Oy ${PROJNAME} >/dev/null 2>&1
  [ "${TESTDIR}" != "" ] && rm -rf ${TESTDIR}
}

@test "install from directory" {
  set -eu -o pipefail
  cd ${TESTDIR}
  echo "# ddev get ${DIR} with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get ${DIR}
  ddev restart
  # verify add-on scan
  ddev exec "curl --location --request POST 'http://test-ddev-a11ywatch-standalone.ddev.site:3280/api/scan' --header 'Content-Type: application/json' --data-raw '{ \"url\": \"https://a11ywatch.com\" }'"
  # verify add-on crawl
  ddev exec "curl --location --request POST 'http://test-ddev-a11ywatch-standalone.ddev.site:3280/api/crawl' --header 'Content-Type: application/json' --data-raw '{ \"url\": \"https://a11ywatch.com\" }'"
}

@test "install from release" {
  set -eu -o pipefail
  cd ${TESTDIR} || ( printf "unable to cd to ${TESTDIR}\n" && exit 1 )
  echo "# ddev get a11ywatch/ddev-a11ywatch with project ${PROJNAME} in ${TESTDIR} ($(pwd))" >&3
  ddev get a11ywatch/ddev-a11ywatch
  ddev restart >/dev/null
  ddev exec "curl --location --request POST 'http://test-ddev-a11ywatch-standalone.ddev.site:3280/api/scan' --header 'Content-Type: application/json' --data-raw '{ \"url\": \"https://a11ywatch.com\" }'"
  # verify add-on crawl
  ddev exec "curl --location --request POST 'http://test-ddev-a11ywatch-standalone.ddev.site:3280/api/crawl' --header 'Content-Type: application/json' --data-raw '{ \"url\": \"https://a11ywatch.com\" }'"
}
