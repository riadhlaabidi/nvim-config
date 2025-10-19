local root_markers = {
  'settings.gradle',
  'settings.gradle.kts',
  'build.gradle',
  'build.gradle.kts',
  'pom.xml',
  '.git',
}

local root = vim.fs.root(0, root_markers)
if root == nil then
  root = vim.fn.getcwd()
end

local project_name = vim.fn.fnamemodify(root, ':p:h:t')
local workspace_root = vim.fn.expand '~/jdtls-workspace'
local workspace_dir = workspace_root .. '/' .. project_name
local jdtls_dir = vim.fn.stdpath 'data' .. '/jdtls'
local config_dir = jdtls_dir .. '/config_linux'
local launcher = jdtls_dir .. '/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar'

local config = {
  cmd = {
    '/usr/lib/jvm/java-21-openjdk/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1G',
    '-jar',
    launcher,
    '-configuration',
    config_dir,
    '-data',
    workspace_dir,
  },
  root_dir = root,
  settings = {
    java = {
      home = '/usr/lib/jvm/java-21-openjdk',
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-11',
            path = '/usr/lib/jvm/java-11-openjdk/',
          },
          {
            name = 'JavaSE-17',
            path = '/usr/lib/jvm/java-17-openjdk/',
          },
          {
            name = 'JavaSE-21',
            path = '/usr/lib/jvm/java-21-openjdk/',
          },
        },
      },
    },
  },

  init_options = {
    bundles = {},
  },
}

require('jdtls').start_or_attach(config)
