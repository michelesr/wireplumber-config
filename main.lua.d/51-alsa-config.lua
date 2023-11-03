local rule = {
  matches = {
    {
      -- match the internal PCI cards, and only Pro Audio profiles
      { 'node.name', 'matches', 'alsa*pci*' },
      { 'device.profile.pro', 'matches', 'true' },
    },
  },
  apply_properties = {
    -- https://pipewire.pages.freedesktop.org/wireplumber/configuration/alsa.html#alsa-buffer-properties

    -- disable timers and use hardware IRQ
    -- when this is true, 'api.alsa.period-size' is set to the quantum, 
    -- and matches the desired latency: this is the default for pro audio
    -- profiles, but it has to be forced on this card due 
    -- to having more than 1 playback and 1 capture devices
    -- see https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/3613#note_2146678
    ['api.alsa.disable-tsched'] = true,

    -- this shouldn't affect latency in theory, but it seems to improve things
    -- with realtime monitoring so leave it on
    --
    -- side effect is that changing quantum at runtime might cause a brief glitch
    ['api.alsa.period-num'] = 2,
  },
}

-- comment/uncomment to disable/enable the rules
table.insert(alsa_monitor.rules, rule)
