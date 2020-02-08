===============================
D3D9Wnd - 0.7.1.1 (14 Apr 2019)
===============================

This WormKit module allows you to run Worms Armageddon v3.7.x in windowed mode. It takes advantage of the game's Direct3D 9 renderer, which also allows for some brilliant features, such as playing the game on several monitors at once, stretching the window, unpinning/pinning mouse from the game window, playing the game using ultra-high screen resolutions, as well as producing and streaming ultra-high-resolution videos and screenshots on any monitor and system.
This is obsolete if you are running version 3.8+ of the game! For those versions, go into Options, and enable "Windowed mode".

Installation:

- Extract the archive's contents into your game folder.
- Enable "Load WormKit modules" by going into Advanced Options, or by importing "LoadWormKitModules_Enabled.reg" from the Tweaks directory (if you can't run the game at all).
- Enable the Direct3D 9 renderer ("shader" preferred) by going into Advanced Options, or by importing "Renderer_Direct3D_9_Shader_palette.reg" from the Tweaks directory.
- Run the game. If needed, you can configure the behavior of the module via the wkD3D9Wnd.ini file.

The following features can be highlighted:

- **Multi-Monitor support**: enable W:A to display the game spanned across several monitors, placed either vertically or horizontally, in either frontend and/or in-game. With AutoSetResolution enabled, the resulting in-game resolution will automatically be set in WA settings on every launch. When using stretched or fullscreen frontend mode, enabling Multi-Mon in-game will not clip your cursor in the frontend area. NOTE: performance has to be considered when enabling this option. Your hardware, mainly CPU and GPU, should be supporting it well to prevent any lags during the gameplay.
	**Limitations**: the display mode has to be "Extend" instead of "Duplicate". Maximum texture size supported by your GPU is the limit for the total resolution of the virtual multi-monitor desktop (if you exceed the limit, WA will tell you and perform a workaround). Differently-sized monitors are supported but not recommended: it's up to you to decide whether to leave empty space by making the smaller monitor primary or, otherwise, cut a few lines by using the bigger one as primary. You should also make monitors as adjacent to each other as possible on the Windows Monitor Mapping screen. Monitors that do not perfectly coincide with each other will cause ruptures in the image and produce incorrect results. Example: two monitors where the top-left corner of the right monitor touches the bottom-right corner of the left monitor.
- **Unpin and pin the mouse**: a feature requested by someone to be able to unpin the mouse in-game and move it over WA's window. This can be useful with Border (see below).
	Ctrl+G to unpin or pin the mouse.
- **Active Background**: available in both Windowed and Stretched modes. Allows to view the gameplay even when the window is not in focus. This is permanently enabled since 0.6.6.6.
- **Run frontend in background**: a feature to prevent the frontend menus from self-minimizing when switching to another window. When it is enabled, the frontend will keep running in background. Can be switched using the "RunInBackground" setting under [FrontendSettings].
- **Frontend Centering** (deprecated): an option to center the frontend window, but your mouse will be clipped to the window, and Hardware Cursors will be disabled. Not recommended for use. You should use SuperFrontendHD instead.
- **Window border in-game and quick info**: allows to have a window border around the window. Using the previously mentioned unpinning feature you are able to move the in-game window.
	Use WindowBorder=1 in the InGame section to enable this. Use Ctrl+D to quickly enable/disable this during gameplay.
There's also a possibility to show quick information by enabling QuickInfo=1 in the [InGame] section. Some quick information like the in-game resolution, mouse pinned state, topmost state and other things can be shown there in real-time.
- **Stretched mode** (deprecated in Frontend): enable "Stretch" in the ini file for either frontend or in-game. It is still windowed mode, but here it is enlarged to fully fill your screen, and looks just the same as if you were in fullscreen. This is especially useful if your monitor doesn't support 640x480 (and you want fullscreen) or if you plan on speeding up your game (by not having to wait until your monitor switches the resolution): instant return to frontend after the game has ended, instant minimization, ability to set the resolution higher than your own, etc.
	**NOTE:** some drivers use nearest-neighbor scaling instead of antialiased by default, so you might need to change that in driver settings.
	**NOTE:** the Stretch option in the Frontend is now obsoleted by SuperFrontendHD. It is NOT recommended to use the Stretch option in the frontend any longer.
- If Direct3D 9 is not enabled, you will be notified. The module will assist with certain issues, should they occur.

D3D9Wnd works on W:A 3.7.x (CD/Steam/GOG) and makes use of the native Direct3D 9 renderer of the game introduced in 3.7. This module is not necessary anymore if you're running version 3.8 or higher (because it includes a built-in windowed mode!).

Additional notes:

- To fully disable the module without deleting it, use "EnableModule=0" in the ini file. To disable it for one session only, run WA with a command-line parameter: /wkargs -nowindow
- This fixes the Windows 7 multiple monitors issue! (thanks to Obn3g0n/JoE for confirming)
- UAC admin mode issue does not occur when maximizing from the taskbar in windowed mode.
- With help of wkLobbyCmd you can switch resolutions on the fly and specify a resolution which is even higher than your own (in this case it'll be stretched to fit the screen). This allows everyone to produce full-HD (and even 4K, etc.) screenshots and videos regardless of their monitor. Aspect ratio does not matter.
	The maximum possible resolution is your GPU's max texture size (4096x4096, 8192x8192 or 16384x16384) and the minimum is 143x1. The module does not adjust to your aspect ratio, by the way. If you want to use a super-resolution that respects your respect ratio, you have to calculate the target resolution yourself (example: 16/9 1280x720 => 16/9 1920x1080).
- The frontend is still in the top left corner. I can't tell more on why this happens right now, but it's due to hardly repairable bugs in the game. This will not be fixed in D3D9Wnd. A new, far better solution is on the horizon.

This module uses MinHook. A copy of the license is located inside the DLL, in the RCData resource section. Thanks to the original developers. More information about MinHook: https://github.com/TsudaKageyu/minhook

SuperFrontendHD is a new module that allows you to expand your frontend to any resolution without losing quality of the graphics. It actually comes with over 1300 HD bitmaps used in the frontend at HD and Full HD! Fully compatible with D3D9Wnd. Check it out here: https://worms2d.info/SuperFrontendHD

Support forums for D3D9Wnd are located on this website: https://www.tus-wa.com/?topic=19063

Credits:
- Kawoosh for the initial version of the module.
- StepS for all the updates that followed.
- MinHook developers for the hooking library which saved the module from the madCHook disaster.
- Deadcode for helping resolve some bugs early on. Locking Windows or disconnecting the monitor no longer crashes the game.
