-- workaround to force 16 bit audio format on the
-- Hisense smart TV, otherwise audio breaks
-- NOTE: it requires restarting wireplumber after
-- plugging the tv on the HDMI port
--      systemctl --user restart wireplumber.service
local rule = {
  matches = {
    {
      { 'node.nick', 'equals', 'Hisense' },
    },
  },
  apply_properties = {
    ['audio.format'] = 'S16LE',
  },
}

table.insert(alsa_monitor.rules, rule)
