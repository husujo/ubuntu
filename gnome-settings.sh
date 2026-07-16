# might get super+q confused with ctrl+tab, ctrl+`, super+tab
gsettings set org.gnome.desktop.wm.keybindings close "['<Shift><Super>C', '<Shift><Super>Q']"
gsettings set org.gnome.desktop.wm.preferences resize-with-right-button "true"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position "BOTTOM"
gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 34
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode "FIXED"
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.1
gsettings set org.gnome.shell.extensions.tiling-assistant enable-tiling-popup false
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.input-sources xkb-options "['shift:both_capslock', 'caps:backspace']"
gsettings set org.gnome.desktop.session idle-delay 600 # screen dim
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1200 # suspend on battery
gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop', 'org.gnome.TextEditor.desktop', 'org.gnome.Nautilus.desktop', 'firefox_firefox.desktop', 'org.gnome.Settings.desktop', 'snap-store_snap-store.desktop']"

GTERM_PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GTERM_PROFILE_ID/ default-size-columns 100
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GTERM_PROFILE_ID/ default-size-rows 30
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ close-tab '<Control>w'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ new-tab '<Control>t'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ new-window '<Control>n'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ paste '<Primary>v'
gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ copy '<Primary>c'
# (!!) for INTERRUPT signal, use ctrl+alt+c

# put settings at the top of the search list
search_order=$(gsettings get org.gnome.desktop.search-providers sort-order)
search_order=$(echo $search_order | sed "s/'org\.gnome\.Nautilus\.desktop',*//g" | sed "s/\[/['org.gnome.Nautilus.desktop', /")
search_order=$(echo $search_order | sed "s/'org\.gnome\.Settings\.desktop',*//g" | sed "s/\[/['org.gnome.Settings.desktop', /")
search_order=$(echo $search_order | sed "s/, \]/]/")
echo "search order: $search_order"
gsettings set org.gnome.desktop.search-providers sort-order "$search_order"

echo "(sudo) remove imagemagick from search results:"
echo "NoDisplay=true" | sudo tee -a /usr/share/applications/display-im6.q16.desktop

command -v system76-power &> /dev/null && system76-power profile performance

# extension list found with `gnome-extensions list --enabled`
# removed: rounded-window-corners@fxgn user-theme@gnome-shell-extensions.gcampax.github.com auto-move-windows@gnome-shell-extensions.gcampax.github.com
EXT_LIST=(just-perfection-desktop@just-perfection extension-list@tu.berry blur-my-shell@aunetx Vitals@CoreCoding.com clipboard-indicator@tudmotu.com scroll-workspaces@gfxmonk.net); for i in "${EXT_LIST[@]}"; do busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s ${i}; done

# https://www.gnome-look.org/p/1316887
# download theme, unzip, move to .theme/, open tweaks

gsettings --schemadir ~/.local/share/gnome-shell/extensions/clipboard-indicator@tudmotu.com/schemas/ set org.gnome.shell.extensions.clipboard-indicator toggle-menu "['<Super>c']"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/Vitals@CoreCoding.com/schemas/ set org.gnome.shell.extensions.vitals hot-sensors "['_memory_usage_', '_processor_usage_', '_network_public_ip_']"
gnome-extensions disable Vitals@CoreCoding.com && gnome-extensions enable Vitals@CoreCoding.com
