pkg_name=haproxy_demo
pkg_origin=jhn190319
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_svc_run="haproxy -f $pkg_svc_config_path/haproxy.conf -db"
pkg_svc_user="root"
pkg_svc_group="root"
pkg_deps=(core/haproxy)
pkg_binds=(
  [backend]="port"
)
pkg_exports=(
  [port]=front-end.port
  [status-port]=status.port
)
pkg_exposes=(port status-port)

do_download() {
    return 0
}

do_build() {
    return 0
}

do_install() {
    return 0
}
