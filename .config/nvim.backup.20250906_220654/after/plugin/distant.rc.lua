local status, distant = pcall(require, "distant")
if not status then
  print("distant is not installed")
  return
end

distant.setup {
  ['*'] = require('distant.settings').chip_default()
}
