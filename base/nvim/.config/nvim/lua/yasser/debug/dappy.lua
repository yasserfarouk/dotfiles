local dappy = require('dap-python')
-- print(vim.g["python3_host_prog"])
dappy.setup(vim.g["python3_host_prog"])
dappy.test_runner = 'pytest'
