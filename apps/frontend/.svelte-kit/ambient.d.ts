// this file is generated — do not edit it

/// <reference types="@sveltejs/kit" />

/**
 * Environment variables [loaded by Vite](https://vitejs.dev/guide/env-and-mode.html#env-files) from `.env` files and `process.env`. Like [`$env/dynamic/private`](https://svelte.dev/docs/kit/$env-dynamic-private), this module cannot be imported into client-side code. This module only includes variables that _do not_ begin with [`config.kit.env.publicPrefix`](https://svelte.dev/docs/kit/configuration#env) _and do_ start with [`config.kit.env.privatePrefix`](https://svelte.dev/docs/kit/configuration#env) (if configured).
 *
 * _Unlike_ [`$env/dynamic/private`](https://svelte.dev/docs/kit/$env-dynamic-private), the values exported from this module are statically injected into your bundle at build time, enabling optimisations like dead code elimination.
 *
 * ```ts
 * import { API_KEY } from '$env/static/private';
 * ```
 *
 * Note that all environment variables referenced in your code should be declared (for example in an `.env` file), even if they don't have a value until the app is deployed:
 *
 * ```
 * MY_FEATURE_FLAG=""
 * ```
 *
 * You can override `.env` values from the command line like so:
 *
 * ```bash
 * MY_FEATURE_FLAG="enabled" npm run dev
 * ```
 */
declare module "$env/static/private" {
  export const SHELL: string;
  export const SESSION_MANAGER: string;
  export const __ETC_PROFILE_DONE: string;
  export const COLORTERM: string;
  export const __HM_SESS_VARS_SOURCED: string;
  export const XDG_CONFIG_DIRS: string;
  export const XDG_SESSION_PATH: string;
  export const NIX_BUILD_CORES: string;
  export const XDG_MENU_PREFIX: string;
  export const TERM_PROGRAM_VERSION: string;
  export const configureFlags: string;
  export const SPEECHD_CMD: string;
  export const VSCODE_INSPECTOR_OPTIONS: string;
  export const mesonFlags: string;
  export const _fifc_comp_count: string;
  export const ICEAUTHORITY: string;
  export const FONTCONFIG_PATH: string;
  export const LANGUAGE: string;
  export const shell: string;
  export const depsHostHost: string;
  export const NODE: string;
  export const NODE_OPTIONS: string;
  export const LC_ADDRESS: string;
  export const _fifc_ordered_comp: string;
  export const LC_NAME: string;
  export const DIRENV_DIR: string;
  export const STRINGS: string;
  export const depsTargetTarget: string;
  export const XCURSOR_PATH: string;
  export const MEMORY_PRESSURE_WRITE: string;
  export const stdenv: string;
  export const LOCALE_ARCHIVE_2_27: string;
  export const npm_config_local_prefix: string;
  export const builder: string;
  export const DESKTOP_SESSION: string;
  export const LC_MONETARY: string;
  export const GTK_RC_FILES: string;
  export const NO_AT_BRIDGE: string;
  export const shellHook: string;
  export const DIRENV_FILE: string;
  export const EDITOR: string;
  export const phases: string;
  export const XDG_SEAT: string;
  export const PWD: string;
  export const NIX_PROFILES: string;
  export const SOURCE_DATE_EPOCH: string;
  export const XDG_SESSION_DESKTOP: string;
  export const LOGNAME: string;
  export const QT_QPA_PLATFORMTHEME: string;
  export const XDG_SESSION_TYPE: string;
  export const NIX_ENFORCE_NO_NATIVE: string;
  export const CUPS_DATADIR: string;
  export const NIX_PATH: string;
  export const BUN_WHICH_IGNORE_CWD: string;
  export const SYSTEMD_EXEC_PID: string;
  export const NIXPKGS_CONFIG: string;
  export const CXX: string;
  export const XAUTHORITY: string;
  export const system: string;
  export const FZF_DEFAULT_COMMAND: string;
  export const VSCODE_GIT_ASKPASS_NODE: string;
  export const HOST_PATH: string;
  export const QT_STYLE_OVERRIDE: string;
  export const VSCODE_INJECTION: string;
  export const XKB_DEFAULT_MODEL: string;
  export const GTK2_RC_FILES: string;
  export const IN_NIX_SHELL: string;
  export const NIXPKGS_QT6_QML_IMPORT_PATH: string;
  export const doInstallCheck: string;
  export const HOME: string;
  export const NIX_BINTOOLS: string;
  export const SSH_ASKPASS: string;
  export const LANG: string;
  export const LC_PAPER: string;
  export const XDG_CURRENT_DESKTOP: string;
  export const depsTargetTargetPropagated: string;
  export const npm_package_version: string;
  export const MEMORY_PRESSURE_WATCH: string;
  export const WAYLAND_DISPLAY: string;
  export const cmakeFlags: string;
  export const outputs: string;
  export const GIO_EXTRA_MODULES: string;
  export const MANROFFOPT: string;
  export const NIX_STORE: string;
  export const GIT_ASKPASS: string;
  export const XDG_SEAT_PATH: string;
  export const LD: string;
  export const INVOCATION_ID: string;
  export const buildPhase: string;
  export const MOAR: string;
  export const MANGOHUD_CONFIGFILE: string;
  export const MANAGERPID: string;
  export const DIRENV_DIFF: string;
  export const INIT_CWD: string;
  export const READELF: string;
  export const GTK_A11Y: string;
  export const CHROME_DESKTOP: string;
  export const KDE_SESSION_UID: string;
  export const NIX_USER_PROFILE_DIR: string;
  export const INFOPATH: string;
  export const doCheck: string;
  export const VSCODE_GIT_ASKPASS_EXTRA_ARGS: string;
  export const XKB_DEFAULT_LAYOUT: string;
  export const depsBuildBuild: string;
  export const XDG_SESSION_CLASS: string;
  export const _fifc_unordered_comp: string;
  export const LC_IDENTIFICATION: string;
  export const TERM: string;
  export const npm_package_name: string;
  export const FZF_CTRL_T_COMMAND: string;
  export const GTK_PATH: string;
  export const SIZE: string;
  export const propagatedNativeBuildInputs: string;
  export const strictDeps: string;
  export const USER: string;
  export const VSCODE_GIT_IPC_HANDLE: string;
  export const TZDIR: string;
  export const QT_WAYLAND_RECONNECT: string;
  export const AR: string;
  export const KDE_SESSION_VERSION: string;
  export const AS: string;
  export const MANPAGER: string;
  export const DISPLAY: string;
  export const NIX_BINTOOLS_WRAPPER_TARGET_HOST_x86_64_unknown_linux_gnu: string;
  export const _fifc_comp_1: string;
  export const _fifc_comp_3: string;
  export const _fifc_comp_2: string;
  export const _fifc_comp_5: string;
  export const _fifc_comp_4: string;
  export const SHLVL: string;
  export const _fifc_comp_7: string;
  export const _fifc_comp_6: string;
  export const _fifc_comp_9: string;
  export const _fifc_comp_8: string;
  export const MOZ_ENABLE_WAYLAND: string;
  export const NM: string;
  export const PAGER: string;
  export const NIX_CFLAGS_COMPILE: string;
  export const LC_TELEPHONE: string;
  export const QTWEBKIT_PLUGIN_PATH: string;
  export const patches: string;
  export const LC_MEASUREMENT: string;
  export const __NIXOS_SET_ENVIRONMENT_DONE: string;
  export const XDG_VTNR: string;
  export const buildInputs: string;
  export const XDG_SESSION_ID: string;
  export const preferLocalBuild: string;
  export const LOCALE_ARCHIVE: string;
  export const LESSKEYIN_SYSTEM: string;
  export const npm_config_user_agent: string;
  export const QML2_IMPORT_PATH: string;
  export const TERMINFO_DIRS: string;
  export const npm_execpath: string;
  export const LD_LIBRARY_PATH: string;
  export const XDG_RUNTIME_DIR: string;
  export const NODE_PATH: string;
  export const depsBuildTarget: string;
  export const OBJCOPY: string;
  export const NIX_XDG_DESKTOP_PORTAL_DIR: string;
  export const out: string;
  export const npm_package_json: string;
  export const LC_TIME: string;
  export const DOCKER_HOST: string;
  export const FONTCONFIG_FILE: string;
  export const VSCODE_GIT_ASKPASS_MAIN: string;
  export const STRIP: string;
  export const QT_AUTO_SCREEN_SCALE_FACTOR: string;
  export const JOURNAL_STREAM: string;
  export const XDG_DATA_DIRS: string;
  export const KDE_FULL_SESSION: string;
  export const GDK_BACKEND: string;
  export const LIBEXEC_PATH: string;
  export const OBJDUMP: string;
  export const PATH: string;
  export const propagatedBuildInputs: string;
  export const dontAddDisableDepTrack: string;
  export const __fish_nixos_env_preinit_sourced: string;
  export const CC: string;
  export const NIX_CC: string;
  export const ORIGINAL_XDG_CURRENT_DESKTOP: string;
  export const DBUS_SESSION_BUS_ADDRESS: string;
  export const depsBuildTargetPropagated: string;
  export const depsBuildBuildPropagated: string;
  export const FZF_DEFAULT_OPTS: string;
  export const DIRENV_WATCHES: string;
  export const KDE_APPLICATIONS_AS_SCOPE: string;
  export const NIX_CC_WRAPPER_TARGET_HOST_x86_64_unknown_linux_gnu: string;
  export const KPACKAGE_DEP_RESOLVERS_PATH: string;
  export const QT_PLUGIN_PATH: string;
  export const CONFIG_SHELL: string;
  export const XKB_DEFAULT_OPTIONS: string;
  export const __structuredAttrs: string;
  export const npm_node_execpath: string;
  export const RANLIB: string;
  export const NIX_HARDENING_ENABLE: string;
  export const LC_NUMERIC: string;
  export const NIX_LDFLAGS: string;
  export const nativeBuildInputs: string;
  export const name: string;
  export const TERM_PROGRAM: string;
  export const depsHostHostPropagated: string;
  export const _: string;
}

/**
 * Similar to [`$env/static/private`](https://svelte.dev/docs/kit/$env-static-private), except that it only includes environment variables that begin with [`config.kit.env.publicPrefix`](https://svelte.dev/docs/kit/configuration#env) (which defaults to `PUBLIC_`), and can therefore safely be exposed to client-side code.
 *
 * Values are replaced statically at build time.
 *
 * ```ts
 * import { PUBLIC_BASE_URL } from '$env/static/public';
 * ```
 */
declare module "$env/static/public" {}

/**
 * This module provides access to runtime environment variables, as defined by the platform you're running on. For example if you're using [`adapter-node`](https://github.com/sveltejs/kit/tree/main/packages/adapter-node) (or running [`vite preview`](https://svelte.dev/docs/kit/cli)), this is equivalent to `process.env`. This module only includes variables that _do not_ begin with [`config.kit.env.publicPrefix`](https://svelte.dev/docs/kit/configuration#env) _and do_ start with [`config.kit.env.privatePrefix`](https://svelte.dev/docs/kit/configuration#env) (if configured).
 *
 * This module cannot be imported into client-side code.
 *
 * Dynamic environment variables cannot be used during prerendering.
 *
 * ```ts
 * import { env } from '$env/dynamic/private';
 * console.log(env.DEPLOYMENT_SPECIFIC_VARIABLE);
 * ```
 *
 * > In `dev`, `$env/dynamic` always includes environment variables from `.env`. In `prod`, this behavior will depend on your adapter.
 */
declare module "$env/dynamic/private" {
  export const env: {
    SHELL: string;
    SESSION_MANAGER: string;
    __ETC_PROFILE_DONE: string;
    COLORTERM: string;
    __HM_SESS_VARS_SOURCED: string;
    XDG_CONFIG_DIRS: string;
    XDG_SESSION_PATH: string;
    NIX_BUILD_CORES: string;
    XDG_MENU_PREFIX: string;
    TERM_PROGRAM_VERSION: string;
    configureFlags: string;
    SPEECHD_CMD: string;
    VSCODE_INSPECTOR_OPTIONS: string;
    mesonFlags: string;
    _fifc_comp_count: string;
    ICEAUTHORITY: string;
    FONTCONFIG_PATH: string;
    LANGUAGE: string;
    shell: string;
    depsHostHost: string;
    NODE: string;
    NODE_OPTIONS: string;
    LC_ADDRESS: string;
    _fifc_ordered_comp: string;
    LC_NAME: string;
    DIRENV_DIR: string;
    STRINGS: string;
    depsTargetTarget: string;
    XCURSOR_PATH: string;
    MEMORY_PRESSURE_WRITE: string;
    stdenv: string;
    LOCALE_ARCHIVE_2_27: string;
    npm_config_local_prefix: string;
    builder: string;
    DESKTOP_SESSION: string;
    LC_MONETARY: string;
    GTK_RC_FILES: string;
    NO_AT_BRIDGE: string;
    shellHook: string;
    DIRENV_FILE: string;
    EDITOR: string;
    phases: string;
    XDG_SEAT: string;
    PWD: string;
    NIX_PROFILES: string;
    SOURCE_DATE_EPOCH: string;
    XDG_SESSION_DESKTOP: string;
    LOGNAME: string;
    QT_QPA_PLATFORMTHEME: string;
    XDG_SESSION_TYPE: string;
    NIX_ENFORCE_NO_NATIVE: string;
    CUPS_DATADIR: string;
    NIX_PATH: string;
    BUN_WHICH_IGNORE_CWD: string;
    SYSTEMD_EXEC_PID: string;
    NIXPKGS_CONFIG: string;
    CXX: string;
    XAUTHORITY: string;
    system: string;
    FZF_DEFAULT_COMMAND: string;
    VSCODE_GIT_ASKPASS_NODE: string;
    HOST_PATH: string;
    QT_STYLE_OVERRIDE: string;
    VSCODE_INJECTION: string;
    XKB_DEFAULT_MODEL: string;
    GTK2_RC_FILES: string;
    IN_NIX_SHELL: string;
    NIXPKGS_QT6_QML_IMPORT_PATH: string;
    doInstallCheck: string;
    HOME: string;
    NIX_BINTOOLS: string;
    SSH_ASKPASS: string;
    LANG: string;
    LC_PAPER: string;
    XDG_CURRENT_DESKTOP: string;
    depsTargetTargetPropagated: string;
    npm_package_version: string;
    MEMORY_PRESSURE_WATCH: string;
    WAYLAND_DISPLAY: string;
    cmakeFlags: string;
    outputs: string;
    GIO_EXTRA_MODULES: string;
    MANROFFOPT: string;
    NIX_STORE: string;
    GIT_ASKPASS: string;
    XDG_SEAT_PATH: string;
    LD: string;
    INVOCATION_ID: string;
    buildPhase: string;
    MOAR: string;
    MANGOHUD_CONFIGFILE: string;
    MANAGERPID: string;
    DIRENV_DIFF: string;
    INIT_CWD: string;
    READELF: string;
    GTK_A11Y: string;
    CHROME_DESKTOP: string;
    KDE_SESSION_UID: string;
    NIX_USER_PROFILE_DIR: string;
    INFOPATH: string;
    doCheck: string;
    VSCODE_GIT_ASKPASS_EXTRA_ARGS: string;
    XKB_DEFAULT_LAYOUT: string;
    depsBuildBuild: string;
    XDG_SESSION_CLASS: string;
    _fifc_unordered_comp: string;
    LC_IDENTIFICATION: string;
    TERM: string;
    npm_package_name: string;
    FZF_CTRL_T_COMMAND: string;
    GTK_PATH: string;
    SIZE: string;
    propagatedNativeBuildInputs: string;
    strictDeps: string;
    USER: string;
    VSCODE_GIT_IPC_HANDLE: string;
    TZDIR: string;
    QT_WAYLAND_RECONNECT: string;
    AR: string;
    KDE_SESSION_VERSION: string;
    AS: string;
    MANPAGER: string;
    DISPLAY: string;
    NIX_BINTOOLS_WRAPPER_TARGET_HOST_x86_64_unknown_linux_gnu: string;
    _fifc_comp_1: string;
    _fifc_comp_3: string;
    _fifc_comp_2: string;
    _fifc_comp_5: string;
    _fifc_comp_4: string;
    SHLVL: string;
    _fifc_comp_7: string;
    _fifc_comp_6: string;
    _fifc_comp_9: string;
    _fifc_comp_8: string;
    MOZ_ENABLE_WAYLAND: string;
    NM: string;
    PAGER: string;
    NIX_CFLAGS_COMPILE: string;
    LC_TELEPHONE: string;
    QTWEBKIT_PLUGIN_PATH: string;
    patches: string;
    LC_MEASUREMENT: string;
    __NIXOS_SET_ENVIRONMENT_DONE: string;
    XDG_VTNR: string;
    buildInputs: string;
    XDG_SESSION_ID: string;
    preferLocalBuild: string;
    LOCALE_ARCHIVE: string;
    LESSKEYIN_SYSTEM: string;
    npm_config_user_agent: string;
    QML2_IMPORT_PATH: string;
    TERMINFO_DIRS: string;
    npm_execpath: string;
    LD_LIBRARY_PATH: string;
    XDG_RUNTIME_DIR: string;
    NODE_PATH: string;
    depsBuildTarget: string;
    OBJCOPY: string;
    NIX_XDG_DESKTOP_PORTAL_DIR: string;
    out: string;
    npm_package_json: string;
    LC_TIME: string;
    DOCKER_HOST: string;
    FONTCONFIG_FILE: string;
    VSCODE_GIT_ASKPASS_MAIN: string;
    STRIP: string;
    QT_AUTO_SCREEN_SCALE_FACTOR: string;
    JOURNAL_STREAM: string;
    XDG_DATA_DIRS: string;
    KDE_FULL_SESSION: string;
    GDK_BACKEND: string;
    LIBEXEC_PATH: string;
    OBJDUMP: string;
    PATH: string;
    propagatedBuildInputs: string;
    dontAddDisableDepTrack: string;
    __fish_nixos_env_preinit_sourced: string;
    CC: string;
    NIX_CC: string;
    ORIGINAL_XDG_CURRENT_DESKTOP: string;
    DBUS_SESSION_BUS_ADDRESS: string;
    depsBuildTargetPropagated: string;
    depsBuildBuildPropagated: string;
    FZF_DEFAULT_OPTS: string;
    DIRENV_WATCHES: string;
    KDE_APPLICATIONS_AS_SCOPE: string;
    NIX_CC_WRAPPER_TARGET_HOST_x86_64_unknown_linux_gnu: string;
    KPACKAGE_DEP_RESOLVERS_PATH: string;
    QT_PLUGIN_PATH: string;
    CONFIG_SHELL: string;
    XKB_DEFAULT_OPTIONS: string;
    __structuredAttrs: string;
    npm_node_execpath: string;
    RANLIB: string;
    NIX_HARDENING_ENABLE: string;
    LC_NUMERIC: string;
    NIX_LDFLAGS: string;
    nativeBuildInputs: string;
    name: string;
    TERM_PROGRAM: string;
    depsHostHostPropagated: string;
    _: string;
    [key: `PUBLIC_${string}`]: undefined;
    [key: `${string}`]: string | undefined;
  };
}

/**
 * Similar to [`$env/dynamic/private`](https://svelte.dev/docs/kit/$env-dynamic-private), but only includes variables that begin with [`config.kit.env.publicPrefix`](https://svelte.dev/docs/kit/configuration#env) (which defaults to `PUBLIC_`), and can therefore safely be exposed to client-side code.
 *
 * Note that public dynamic environment variables must all be sent from the server to the client, causing larger network requests — when possible, use `$env/static/public` instead.
 *
 * Dynamic environment variables cannot be used during prerendering.
 *
 * ```ts
 * import { env } from '$env/dynamic/public';
 * console.log(env.PUBLIC_DEPLOYMENT_SPECIFIC_VARIABLE);
 * ```
 */
declare module "$env/dynamic/public" {
  export const env: {
    [key: `PUBLIC_${string}`]: string | undefined;
  };
}
