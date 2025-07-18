include std/ffi.e
include std/machine.e
include std/os.e
include std/math.e

public atom rgfw

ifdef WINDOWS then
	rgfw = open_dll("rgfw.dll")
	elsifdef LINUX or FREEBSD then
	rgfw = open_dll("librgfw.so")
	elsifdef OSX then
	rgfw = open_dll("librgfw.dylib")
end ifdef

if rgfw = 0 then
	puts(1,"Failed to load rgfw!\n")
	abort(0)
end if

printf(1,"%d",{rgfw})

public constant RGFW_TRUE = 1
public constant RGFW_FALSE = 0

public constant RGFW_COCOA_FRAME_NAME = NULL

public constant RGFW_MAX_PATH = 260
public constant RGFW_MAX_DROPS = 260

public constant xRGFW_useWayland = define_c_proc(rgfw,"+RGFW_useWayland",{C_BOOL})

public procedure RGFW_useWayland(integer wayland)
	c_proc(xRGFW_useWayland,{wayland})
end procedure

public constant xRGFW_usingWayland = define_c_func(rgfw,"+RGFW_usingWayland",{},C_BOOL)

public function RGFW_usingWayland()
	return c_func(xRGFW_usingWayland,{})
end function

public constant RGFW_key = C_UINT8

public enum type RGFW_eventType
	RGFW_eventNone = 0, /*!< no event has been sent */
 	RGFW_keyPressed, /* a key has been pressed */
	RGFW_keyReleased, /*!< a key has been released */
	/*! key event note
		the code of the key pressed is stored in
		RGFW_event.key
		!!Keycodes defined at the bottom of the RGFW_HEADER part of this file!!

		while a string version is stored in
		RGFW_event.KeyString

		RGFW_event.keyMod holds the current keyMod
		this means if CapsLock, NumLock are active or not
	*/
	RGFW_mouseButtonPressed, /*!< a mouse button has been pressed (left,middle,right) */
	RGFW_mouseButtonReleased, /*!< a mouse button has been released (left,middle,right) */
	RGFW_mousePosChanged, /*!< the position of the mouse has been changed */
	/*! mouse event note
		the x and y of the mouse can be found in the vector, RGFW_event.point

		RGFW_event.button holds which mouse button was pressed
	*/
	RGFW_windowMoved, /*!< the window was moved (by the user) */
	RGFW_windowResized, /*!< the window was resized (by the user), [on WASM this means the browser was resized] */
	RGFW_focusIn, /*!< window is in focus now */
	RGFW_focusOut, /*!< window is out of focus now */
	RGFW_mouseEnter, /* mouse entered the window */
	RGFW_mouseLeave, /* mouse left the window */
	RGFW_windowRefresh, /* The window content needs to be refreshed */

	/* attribs change event note
		The event data is sent straight to the window structure
		with win->r.x, win->r.y, win->r.w and win->r.h
	*/
	RGFW_quit, /*!< the user clicked the quit button */
	RGFW_DND, /*!< a file has been dropped into the window */
	RGFW_DNDInit, /*!< the start of a dnd event, when the place where the file drop is known */
	/* dnd data note
		The x and y coords of the drop are stored in the vector RGFW_event.point

		RGFW_event.droppedFilesCount holds how many files were dropped

		This is also the size of the array which stores all the dropped file string,
		RGFW_event.droppedFiles
	*/
	RGFW_windowMaximized, /*!< the window was maximized */
	RGFW_windowMinimized, /*!< the window was minimized */
	RGFW_windowRestored, /*!< the window was restored */
	RGFW_scaleUpdated
end type

public enum type RGFW_mouseButton
	RGFW_mouseLeft = 0, /*!< left mouse button is pressed */
	RGFW_mouseMiddle, /*!< mouse-wheel-button is pressed */
	RGFW_mouseRight, /*!< right mouse button is pressed */
	RGFW_mouseScrollUp, /*!< mouse wheel is scrolling up */
	RGFW_mouseScrollDown, /*!< mouse wheel is scrolling down */
	RGFW_mouseMisc1, RGFW_mouseMisc2, RGFW_mouseMisc3, RGFW_mouseMisc4, RGFW_mouseMisc5,
	RGFW_mouseFinal
end type

public enum type RGFW_keymod
	RGFW_modCapsLock = 1,
	RGFW_modNumLock = 2,
	RGFW_modControl = 4,
	RGFW_modAlt = 8,
	RGFW_modShift = 16,
	RGFW_modSuper = 32,
	RGFW_modScrollLock = 64
end type

public constant RGFW_point = define_c_struct({
	C_INT32, --x
	C_INT32  --y
})

public constant RGFW_rect = define_c_struct({
	C_INT32, --x
	C_INT32, --y
	C_INT32, --w
	C_INT32  --h
})

public constant RGFW_area = define_c_struct({
	C_UINT32, --w
	C_UINT32  --h
})

public constant RGFW_monitorMode = define_c_struct({
	RGFW_area, --area
	C_UINT32,  --refreshRate
	C_UINT8,   --red
	C_UINT8,   --green
	C_UINT8    --blue
})

public constant RGFW_monitor = define_c_struct({
	C_INT32, 		 --x
	C_INT32,         --y
	{C_CHAR,128},    --name[128]
	C_FLOAT,	     --scaleX
	C_FLOAT,	     --scaleY
	C_FLOAT,	     --physW
	C_FLOAT,	     --physH
	RGFW_monitorMode --mode
})

public constant xRGFW_getMonitors = define_c_func(rgfw,"+RGFW_getMonitors",{C_POINTER},C_POINTER)

public function RGFW_getMonitors(atom len)

	atom plen = allocate_data(sizeof(C_SIZE_T))
	
	if c_func(xRGFW_getMonitors,{plen}) then
		len = peek_type(plen,C_SIZE_T)	
	end if
	
	free(plen)
	
	return {len}
	
end function

public constant xRGFW_getPrimaryMonitor = define_c_func(rgfw,"+RGFW_getPrimaryMonitor",{},RGFW_monitor)

public function RGFW_getPrimaryMonitor()
	return c_func(xRGFW_getPrimaryMonitor,{})
end function

public enum type RGFW_modeRequest
	RGFW_monitorScale = 1,
	RGFW_monitorRefresh = 2,
	RGFW_monitorRGB = 4,
	RGFW_monitorAll = 7
end type

public constant xRGFW_monitor_requestMode = define_c_func(rgfw,"+RGFW_monitor_requestMode",{RGFW_monitor,RGFW_monitorMode,C_INT},C_BOOL)

public function RGFW_monitor_requestMode(sequence mon,sequence mode,atom request)
	return c_func(xRGFW_monitor_requestMode,{mon,mode,request})
end function

public constant xRGFW_monitorModeCompare = define_c_func(rgfw,"+RGFW_monitorModeCompare",{RGFW_monitorMode,RGFW_monitorMode,C_INT},C_BOOL)

public function RGFW_monitorModeCompare(sequence mon,sequence mon2,atom request)
	return c_func(xRGFW_monitorModeCompare,{mon,mon2,request})
end function

public constant xRGFW_loadMouse = define_c_func(rgfw,"RGFW_loadMouse",{C_POINTER,RGFW_area,C_INT32},C_POINTER)

public function RGFW_loadMouse(atom icon,sequence a,atom channels)

	atom picon = allocate_data(sizeof(C_POINTER))
	
	if c_func(xRGFW_loadMouse,{picon,a,channels}) then
		icon = peek_type(picon,C_POINTER)
	end if
	
	free(picon)
	
	return {icon,a,channels}
end function

public constant xRGFW_freeMouse = define_c_proc(rgfw,"+RGFW_freeMouse",{C_POINTER})

public procedure RGFW_freeMouse(atom mouse)
	c_proc(xRGFW_freeMouse,{mouse})
end procedure

public constant RGFW_event = define_c_struct({
	C_INT, 		--RGFW eventType
	RGFW_point, --point
	RGFW_point, --vector
	C_FLOAT,    --scaleX
	C_FLOAT,    --scaleY
	RGFW_key,   --key
	C_UINT8,    --keyChar
	C_BOOL,		--repeat
	C_INT,		--keyMode RGFW_keymode
	C_UINT8,	--button
	C_DOUBLE,	--scroll
	C_POINTER,	--droppedFiles
	C_SIZE_T,	--droppedFilesCount
	C_POINTER	--win
})

public enum type RGFW_windowFlags
	RGFW_windowNoInitAPI = 1,
	RGFW_windowNoBorder = 2,
	RGFW_windowNoResize = 4,
	RGFW_windowAllowDND = 8,
	RGFW_windowHideMouse = 16,
	RGFW_windowFullscreen = 32,
	RGFW_windowTransparent = 64,
	RGFW_windowCenter = 128,
	RGFW_windowOpenglSoftware = 256,
	RGFW_windowCocoaCHDToRes  = 512,
	RGFW_windowScaleToMonitor = 1024,
	RGFW_windowHide			  = 2048,
	RGFW_windowMaximize		  = 4096,
	RGFW_windowCenterCursor   = 8192,
	RGFW_windowFloating		  = 16384,
	RGFW_windowFreeOnClose	  = 32768,
	RGFW_windowFocusOnShow    = 65536,
	RGFW_windowMinimize  	  = 131072,
	RGFW_windowFocus		  = 262144,
	RGFW_windowedFullScreen   = 4098
end type

public constant RGFW_window_src = define_c_struct({
	C_POINTER, --window
	C_POINTER,  --hdc
	C_UINT32,   --hOffset
	C_POINTER, --hIconSmall
	C_POINTER,  --hIconBig
	C_POINTER, --ctx
	C_POINTER, --EGLSurface
	C_POINTER, --EGLDisplay
	C_POINTER, --EGLContext
	C_POINTER, --hdcMem
	C_POINTER, --bitmap
	C_POINTER, --bitmapBits
	RGFW_area, --maxSize
	RGFW_area, --minSize
	RGFW_area  --aspectRatio
})

public constant RGFW_window = define_c_struct({
	RGFW_window_src, --src
	C_POINTER, --buffer
	RGFW_area, --bufferSize
	C_POINTER, --usePtr
	RGFW_event, --event
	RGFW_rect,  --rect
	RGFW_key, --exitKey
	RGFW_point, --lastMousePoint
	C_UINT32, --flags
	RGFW_rect --oldRect
})

public constant xRGFW_monitor_scaleToWindow = define_c_func(rgfw,"+RGFW_monitor_scaleToWindow",{RGFW_monitor,C_POINTER},C_BOOL)

public function RGFW_monitor_scaleToWindow(sequence mon,atom win)
	return c_func(xRGFW_monitor_scaleToWindow,{mon,win})
end function

public constant xRGFW_setClassName = define_c_proc(rgfw,"+RGFW_setClassName",{C_STRING}),
				xRGFW_setXInstName = define_c_proc(rgfw,"+RGFW_setXInstName",{C_STRING})
				
public procedure RGFW_setClassName(sequence name)
	c_proc(xRGFW_setClassName,{name})
end procedure
				
public procedure RGFW_setXInstName(sequence name)
	c_proc(xRGFW_setXInstName,{name})
end procedure

public constant xRGFW_moveToMacOSResourceDir = define_c_proc(rgfw,"+RGFW_moveToMacOSResourceDir",{})

public procedure RGFW_moveToMacOSResourceDir()
	c_proc(xRGFW_moveToMacOSResourceDir,{})
end procedure

public constant xRGFW_createWindow = define_c_func(rgfw,"+RGFW_createWindow",{C_STRING,RGFW_rect,C_INT},C_POINTER)

public function RGFW_createWindow(sequence name,sequence rect,atom flags)
	return c_func(xRGFW_createWindow,{name,rect,flags})
end function

public constant xRGFW_createWindowPtr = define_c_func(rgfw,"+RGFW_createWindowPtr",{C_STRING,RGFW_rect,C_INT,C_POINTER},C_POINTER)

public function RGFW_createWindowPtr(sequence name,sequence rect,atom flags,atom win)
	return c_func(xRGFW_createWindowPtr,{name,rect,flags,win})
end function

public constant xRGFW_window_initBuffer = define_c_proc(rgfw,"+RGFW_window_initBuffer",{C_POINTER})

public procedure RGFW_window_initBuffer(atom win)
	c_proc(xRGFW_window_initBuffer,{win})
end procedure

public constant xRGFW_window_initBufferSize = define_c_proc(rgfw,"+RGFW_window_initBufferSize",{C_POINTER,RGFW_area})

public procedure RGFW_window_initBufferSize(atom win,sequence area)
	c_proc(xRGFW_window_initBufferSize,{win,area})
end procedure

public constant xRGFW_window_initBufferPtr = define_c_proc(rgfw,"+RGFW_window_initBufferPtr",{C_POINTER,C_POINTER,RGFW_area})

public procedure RGFW_window_initBufferPtr(atom win,atom buffer,sequence area)
	c_proc(xRGFW_window_initBufferPtr,{win,buffer,area})
end procedure

public constant xRGFW_window_setFlags = define_c_proc(rgfw,"+RGFW_window_setFlags",{C_POINTER,C_INT})

public procedure RGFW_window_setFlags(atom win,atom flags)
	c_proc(xRGFW_window_setFlags,{win,flags})
end procedure

public constant xRGFW_getScreenSize = define_c_func(rgfw,"+RGFW_getScreenSize",{},RGFW_area)

public function RGFW_getScreenSize()
	return c_func(xRGFW_getScreenSize,{})
end function

public constant xRGFW_window_checkEvent = define_c_func(rgfw,"+RGFW_window_checkEvent",{C_POINTER},C_POINTER)

public function RGFW_window_checkEvent(atom win)
	return c_func(xRGFW_window_checkEvent,{win})
end function

public enum type RGFW_eventWait
	RGFW_eventNoWait = 0,
	RGFW_eventWaitNext = 1
end type

public constant xRGFW_window_eventWait = define_c_proc(rgfw,"+RGFW_window_eventWait",{C_POINTER,C_INT32})

public procedure RGFW_window_eventWait(atom win,atom waitMS)
	c_proc(xRGFW_window_eventWait,{win,waitMS})
end procedure

public constant xRGFW_window_checkEvents = define_c_proc(rgfw,"+RGFW_window_checkEvents",{C_POINTER,C_INT32})

public procedure RGFW_window_checkEvents(atom win,atom waitMS)
	c_proc(xRGFW_window_checkEvents,{win,waitMS})
end procedure

public constant xRGFW_stopCheckEvents = define_c_proc(rgfw,"+RGFW_stopCheckEvents",{})

public procedure RGFW_stopCheckEvents()
	c_proc(xRGFW_stopCheckEvents,{})
end procedure

public constant xRGFW_window_close = define_c_proc(rgfw,"+RGFW_window_close",{C_POINTER})

public procedure RGFW_window_close(atom win)
	c_proc(xRGFW_window_close,{win})
end procedure

public constant xRGFW_window_move = define_c_proc(rgfw,"+RGFW_window_move",{C_POINTER,RGFW_point})

public procedure RGFW_window_move(atom win,sequence v)
	c_proc(xRGFW_window_move,{win,v})
end procedure

public constant xRGFW_window_moveToMonitor = define_c_proc(rgfw,"+RGFW_window_moveToMonitor",{C_POINTER,RGFW_monitor})

public procedure RGFW_window_moveToMonitor(atom win,sequence m)
	c_proc(xRGFW_window_moveToMonitor,{win,m})
end procedure

public constant xRGFW_window_resize = define_c_proc(rgfw,"+RGFW_window_resize",{C_POINTER,RGFW_area})

public procedure RGFW_window_resize(atom win,sequence a)
	c_proc(xRGFW_window_resize,{win,a})
end procedure

public constant xRGFW_window_setAspectRatio = define_c_proc(rgfw,"+RGFW_window_setAspectRatio",{C_POINTER,RGFW_area})

public procedure RGFW_window_setAspectRatio(atom win,sequence a)
	c_proc(xRGFW_window_setAspectRatio,{win,a})
end procedure

public constant xRGFW_window_setMinSize = define_c_proc(rgfw,"+RGFW_window_setMinSize",{C_POINTER,RGFW_area})

public procedure RGFW_window_setMinSize(atom win,sequence a)
	c_proc(xRGFW_window_setMinSize,{win,a})
end procedure

public constant xRGFW_window_setMaxSize = define_c_proc(rgfw,"+RGFW_window_setMaxSize",{C_POINTER,RGFW_area})

public procedure RGFW_window_setMaxSize(atom win,sequence a)
	c_proc(xRGFW_window_setMaxSize,{win,a})
end procedure

public constant xRGFW_window_focus = define_c_proc(rgfw,"+RGFW_window_focus",{C_POINTER})

public procedure RGFW_window_focus(atom win)
	c_proc(xRGFW_window_focus,{win})
end procedure

public constant xRGFW_window_isInFocus = define_c_func(rgfw,"+RGFW_window_isInFocus",{C_POINTER},C_BOOL)

public function RGFW_window_isInFocus(atom win)
	return c_func(xRGFW_window_isInFocus,{win})
end function

public constant xRGFW_window_raise = define_c_proc(rgfw,"+RGFW_window_raise",{C_POINTER})

public procedure RGFW_window_raise(atom win)
	c_proc(xRGFW_window_raise,{win})
end procedure

public constant xRGFW_window_maximize = define_c_proc(rgfw,"+RGFW_window_maximize",{C_POINTER})

public procedure RGFW_window_maximize(atom win)
	c_proc(xRGFW_window_maximize,{win})
end procedure

public constant xRGFW_window_setFullscreen = define_c_proc(rgfw,"+RGFW_window_setFullscreen",{C_POINTER,C_BOOL})

public procedure RGFW_window_setFullscreen(atom win,atom fullscreen)
	c_proc(xRGFW_window_setFullscreen,{win,fullscreen})
end procedure

public constant xRGFW_window_center = define_c_proc(rgfw,"+RGFW_window_center",{C_POINTER})

public procedure RGFW_window_center(atom win)
	c_proc(xRGFW_window_center,{win})
end procedure

public constant xRGFW_window_minimize = define_c_proc(rgfw,"+RGFW_window_minimize",{C_POINTER})

public procedure RGFW_window_minimize(atom win)
	c_proc(xRGFW_window_minimize,{win})
end procedure

public constant xRGFW_window_restore = define_c_proc(rgfw,"+RGFW_window_restore",{C_POINTER})

public procedure RGFW_window_restore(atom win)
	c_proc(xRGFW_window_restore,{win})
end procedure

public constant xRGFW_window_setFloating = define_c_proc(rgfw,"+RGFW_window_setFloating",{C_POINTER,C_BOOL})

public procedure RGFW_window_setFloating(atom win,atom floating)
	c_proc(xRGFW_window_setFloating,{win,floating})
end procedure

public constant xRGFW_window_setOpacity = define_c_proc(rgfw,"+RGFW_window_setOpacity",{C_POINTER,C_UINT8})

public procedure RGFW_window_setOpacity(atom win,atom opacity)
	c_proc(xRGFW_window_setOpacity,{win,opacity})
end procedure

public constant xRGFW_window_opengl_isSoftware = define_c_func(rgfw,"+RGFW_window_opengl_isSoftware",{C_POINTER},C_BOOL)

public function RGFW_window_opengl_isSoftware(atom win)
	return c_func(xRGFW_window_opengl_isSoftware,{win})
end function

public constant xRGFW_window_setBorder = define_c_proc(rgfw,"+RGFW_window_setBorder",{C_POINTER,C_BOOL})

public procedure RGFW_window_setBorder(atom win,atom border)
	c_proc(xRGFW_window_setBorder,{win,border})
end procedure

public constant xRGFW_window_borderless = define_c_func(rgfw,"+RGFW_window_borderless",{C_POINTER},C_BOOL)

public function RGFW_window_borderless(atom win)
	return c_func(xRGFW_window_borderless,{win})
end function

public constant xRGFW_window_setDND = define_c_proc(rgfw,"+RGFW_window_setDND",{C_POINTER,C_BOOL})

public procedure RGFW_window_setDND(atom win,atom allow)
	c_proc(xRGFW_window_setDND,{win,allow})
end procedure

public constant xRGFW_window_allowsDND = define_c_func(rgfw,"+RGFW_window_allowsDND",{C_POINTER},C_BOOL)

public function RGFW_window_allowsDND(atom win)
	return c_func(xRGFW_window_allowsDND,{win})
end function

public constant xRGFW_window_setMousePassthrough = define_c_proc(rgfw,"+RGFW_window_setMousePassthrough",{C_POINTER,C_BOOL})

public procedure RGFW_window_setMousePassthrough(atom win,atom passthrough)
	c_proc(xRGFW_window_setMousePassthrough,{win,passthrough})
end procedure

public constant xRGFW_window_setName = define_c_proc(rgfw,"+RGFW_window_setName",{C_POINTER,C_STRING})

public procedure RGFW_window_setName(atom win,sequence name)
	c_proc(xRGFW_window_setName,{win,name})
end procedure

public constant xRGFW_window_setIcon = define_c_func(rgfw,"+RGFW_window_setIcon",{C_POINTER,C_POINTER,RGFW_area,C_INT32},C_BOOL)

public function RGFW_window_setIcon(atom win,atom icon,sequence a,atom channels)
	return c_func(xRGFW_window_setIcon,{win,icon,a,channels})
end function

public enum type RGFW_icon
	RGFW_iconTaskbar = 1,
	RGFW_iconWindow = 2,
	RGFW_iconBoth = 3
end type

public constant xRGFW_window_setIconEx = define_c_func(rgfw,"+RGFW_window_setIconEx",{C_POINTER,C_POINTER,RGFW_area,C_INT32,C_UINT8},C_BOOL)

public function RGFW_window_setIconEx(atom win,atom icon,sequence a,atom channels,atom xtype)
	return c_func(xRGFW_window_setIconEx,{win,icon,a,channels,xtype})
end function

public constant xRGFW_window_setMouse = define_c_proc(rgfw,"+RGFW_window_setMouse",{C_POINTER,C_POINTER})

public procedure RGFW_window_setMouse(atom win,atom mouse)
	c_proc(xRGFW_window_setMouse,{win,mouse})
end procedure

public constant xRGFW_window_setMouseStandard = define_c_func(rgfw,"+RGFW_window_setMouseStandard",{C_POINTER,C_UINT8},C_BOOL)

public function RGFW_window_setMouseStandard(atom win,atom mouse)
	return c_func(xRGFW_window_setMouseStandard,{win,mouse})
end function

public constant xRGFW_window_setMouseDefault = define_c_func(rgfw,"+RGFW_window_setMouseDefault",{C_POINTER},C_BOOL)

public function RGFW_window_setMouseDefault(atom win)
	return c_func(xRGFW_window_setMouseDefault,{win})
end function

public constant xRGFW_window_mouseHold = define_c_proc(rgfw,"+RGFW_window_mouseHold",{C_POINTER,RGFW_area})

public procedure RGFW_window_mouseHold(atom win,sequence area)
	c_proc(xRGFW_window_mouseHold,{win,area})
end procedure

public constant xRGFW_window_mouseHeld = define_c_func(rgfw,"+RGFW_window_mouseHeld",{C_POINTER},C_BOOL)

public function RGFW_window_mouseHeld(atom win)
	return c_func(xRGFW_window_mouseHeld,{win})
end function

public constant xRGFW_window_mouseUnhold = define_c_proc(rgfw,"+RGFW_window_mouseUnhold",{C_POINTER})

public procedure RGFW_window_mouseUnhold(atom win)
	c_proc(xRGFW_window_mouseUnhold,{win})
end procedure

public constant xRGFW_window_hide = define_c_proc(rgfw,"+RGFW_window_hide",{C_POINTER})

public procedure RGFW_window_hide(atom win)
	c_proc(xRGFW_window_hide,{win})
end procedure

public constant xRGFW_window_show = define_c_proc(rgfw,"+RGFW_window_show",{C_POINTER})

public procedure RGFW_window_show(atom win)
	c_proc(xRGFW_window_show,{win})
end procedure

public constant xRGFW_window_setShouldClose = define_c_proc(rgfw,"+RGFW_window_setShouldClose",{C_POINTER,C_BOOL})

public procedure RGFW_window_setShouldClose(atom win,atom shouldClose)
	c_proc(xRGFW_window_setShouldClose,{win,shouldClose})
end procedure

public constant xRGFW_getGlobalMousePoint = define_c_func(rgfw,"+RGFW_getGlobalMousePoint",{},RGFW_point)

public function RGFW_getGlobalMousePoint()
	return c_func(xRGFW_getGlobalMousePoint,{})
end function

public constant xRGFW_window_getMousePoint = define_c_func(rgfw,"+RGFW_window_getMousePoint",{C_POINTER},RGFW_point)

public function RGFW_window_getMousePoint(atom win)
	return c_func(xRGFW_window_getMousePoint,{win})
end function

public constant xGFW_window_showMouse = define_c_proc(rgfw,"+GFW_window_showMouse",{C_POINTER,C_BOOL})

public procedure GFW_window_showMouse(atom win,atom show)
	c_proc(xGFW_window_showMouse,{win,show})
end procedure

public constant xRGFW_window_mouseHidden = define_c_func(rgfw,"+RGFW_window_mouseHidden",{C_POINTER},C_BOOL)

public function RGFW_window_mouseHidden(atom win)
	return c_func(xRGFW_window_mouseHidden,{win})
end function

public constant xRGFW_window_moveMouse = define_c_proc(rgfw,"+RGFW_window_moveMouse",{C_POINTER,RGFW_point})

public procedure RGFW_window_moveMouse(atom win,sequence v)
	c_proc(xRGFW_window_moveMouse,{win,v})
end procedure

public constant xRGFW_window_shouldClose = define_c_func(rgfw,"+RGFW_window_shouldClose",{C_POINTER},C_BOOL)

public function RGFW_window_shouldClose(atom win)
	return c_func(xRGFW_window_shouldClose,{win})
end function

public constant xRGFW_window_isFullscreen = define_c_func(rgfw,"+RGFW_window_isFullscreen",{C_POINTER},C_BOOL)

public function RGFW_window_isFullscreen(atom win)
	return c_func(xRGFW_window_isFullscreen,{win})
end function

public constant xRGFW_window_isHidden = define_c_func(rgfw,"+RGFW_window_isHidden",{C_POINTER},C_BOOL)

public function RGFW_window_isHidden(atom win)
	return c_func(xRGFW_window_isHidden,{win})
end function

public constant xRGFW_window_isMinimized = define_c_func(rgfw,"+RGFW_window_isMinimized",{C_POINTER},C_BOOL)

public function RGFW_window_isMinimized(atom win)
	return c_func(xRGFW_window_isMinimized,{win})
end function

public constant xRGFW_window_isMaximized = define_c_func(rgfw,"+RGFW_window_isMaximized",{C_POINTER},C_BOOL)

public function RGFW_window_isMaximized(atom win)
	return c_func(xRGFW_window_isMaximized,{win})
end function

public constant xRGFW_window_isFloating = define_c_func(rgfw,"+RGFW_window_isFloating",{C_POINTER},C_BOOL)

public function RGFW_window_isFloating(atom win)
	return c_func(xRGFW_window_isFloating,{win})
end function

public constant xRGFW_window_scaleToMonitor = define_c_proc(rgfw,"+RGFW_window_scaleToMonitor",{C_POINTER})

public procedure RGFW_window_scaleToMonitor(atom win)
	c_proc(xRGFW_window_scaleToMonitor,{win})
end procedure

public constant xRGFW_window_getMonitor = define_c_func(rgfw,"+RGFW_window_getMonitor",{C_POINTER},RGFW_monitor)

public function RGFW_window_getMonitor(atom win)
	return c_func(xRGFW_window_getMonitor,{win})
end function

public constant xRGFW_isPressed = define_c_func(rgfw,"+RGFW_isPressed",{C_POINTER,C_INT},C_BOOL)

public function RGFW_isPressed(atom win,atom key)
	return c_func(xRGFW_isPressed,{win,key})
end function

public constant xRGFW_wasPressed = define_c_func(rgfw,"+RGFW_wasPressed",{C_POINTER,C_INT},C_BOOL)

public function RGFW_wasPressed(atom win,atom key)
	return c_func(xRGFW_wasPressed,{win,key})
end function

public constant xRGFW_isHeld = define_c_func(rgfw,"+RGFW_isHeld",{C_POINTER,C_INT},C_BOOL)

public function RGFW_isHeld(atom win,atom key)
	return c_func(xRGFW_isHeld,{win,key})
end function

public constant xRGFW_isReleased = define_c_func(rgfw,"+RGFW_isReleased",{C_POINTER,C_INT},C_BOOL)

public function RGFW_isReleased(atom win,atom key)
	return c_func(xRGFW_isReleased,{win,key})
end function

public constant xRGFW_isClicked = define_c_func(rgfw,"+RGFW_isClicked",{C_POINTER,C_INT},C_BOOL)

public function RGFW_isClicked(atom win,atom key)
	return c_func(xRGFW_isClicked,{win,key})
end function

public constant xRGFW_isMousePressed = define_c_func(rgfw,"+RGFW_isMousePressed",{C_POINTER,C_INT},C_BOOL)

public function RGFW_isMousePressed(atom win,atom button)
	return c_func(xRGFW_isMousePressed,{win,button})
end function

public constant xRGFW_isMouseHeld = define_c_func(rgfw,"+RGFW_isMouseHeld",{C_POINTER,C_INT},C_BOOL)

public function RGFW_isMouseHeld(atom win,atom button)
	return c_func(xRGFW_isMouseHeld,{win,button})
end function

public constant xRGFW_isMouseReleased = define_c_func(rgfw,"+RGFW_isMouseReleased",{C_POINTER,C_INT},C_BOOL)

public function RGFW_isMouseReleased(atom win,atom button)
	return c_func(xRGFW_isMouseReleased,{win,button})
end function

public constant xRGFW_wasMousePressed = define_c_func(rgfw,"+RGFW_wasMousePressed",{C_POINTER,C_INT},C_BOOL)

public function RGFW_wasMousePressed(atom win,atom button)
	return c_func(xRGFW_wasMousePressed,{win,button})
end function

public constant xRGFW_readClipboard = define_c_func(rgfw,"+RGFW_readClipboard",{C_POINTER},C_STRING)

public function RGFW_readClipboard(atom size)
	atom psize = allocate_data(sizeof(C_SIZE_T))
	
	if c_func(xRGFW_readClipboard,{psize}) then
		size = peek_type(psize,C_SIZE_T)
	end if
	
	free(psize)
	
	return {size}
end function

public constant xRGFW_readClipboardPtr = define_c_func(rgfw,"+RGFW_readClipboardPtr",{C_STRING,C_SIZE_T},C_SIZE_T)

public function RGFW_readClipboardPtr(sequence str,atom capacity)
	return c_func(xRGFW_readClipboardPtr,{str,capacity})
end function

public constant xRGFW_writeClipboard = define_c_proc(rgfw,"+RGFW_writeClipboard",{C_STRING,C_UINT32})

public procedure RGFW_writeClipboard(sequence text,atom textLen)
	c_proc(xRGFW_writeClipboard,{text,textLen})
end procedure

public enum type RGFW_debugType
	RGFW_typeError = 0,
	RGFW_typeWarning,
	RGFW_typeInfo
end type

public enum type RGFW_errorCode
	RGFW_noError = 0,
	RGFW_errOutOfMemory,
	RGFW_errOpenglContext,
	RGFW_errEGLContext,
	RGFW_errWayland,RGFW_errX11,
	RGFW_errIOKit,
	RGFW_errClipboard,
	RGFW_errFailedFuncLoad,
	RGFW_errBuffer,
	RGFW_errEventQueue,
	RGFW_infoMonitor,RGFW_infoWindow,RGFW_infoBuffer,
	RGFW_infoGlobal,RGFW_infoOpenGL,
	RGFW_warningWayland,RGFW_warningOpenGL
end type

public constant RGFW_debugContext = define_c_struct({
	C_POINTER, --win
	C_POINTER, --monitor
	C_UINT32 --srcError
})

public function on_debug(integer dtype,integer err,atom ctx,atom msg_ptr)
	sequence msg = peek_string(msg_ptr)
	printf(1,"DEBUG Type: %d Error: %d Msg: %s\n",{dtype,err,msg})
	return 0
end function

atom rid = routine_id("on_debug")
atom debug_cb = call_back(rid,{C_INT,C_INT,C_POINTER,C_POINTER},C_VOID)

public constant xRGFW_setDebugCallback = define_c_func(rgfw,"+RGFW_setDebugCallback",{C_POINTER},C_POINTER)

public function RGFW_setDebugCallback(object func=debug_cb)
	return c_func(xRGFW_setDebugCallback,{func})
end function

public constant xRGFW_sendDebugInfo = define_c_proc(rgfw,"+RGFW_sendDebugInfo",{C_INT,C_INT,RGFW_debugContext,C_STRING})

public procedure RGFW_sendDebugInfo(atom xtype,atom err,object ctx,sequence msg)
	c_proc(xRGFW_sendDebugInfo,{xtype,err,ctx,msg})
end procedure

public function window_moved_cb(atom win_ptr,object rect)
	printf(1,"Window moved to x:%d,y:%d,w:%d,h:%d\n",{rect})
	return 0
end function

atom win_move_id = routine_id("window_moved_cb")
atom win_move_cb = call_back(win_move_id,{C_POINTER,RGFW_rect},C_VOID)

public constant xRGFW_setWindowMovedCallback = define_c_func(rgfw,"+RGFW_setWindowMovedCallback",{C_POINTER},C_POINTER)

public function RGFW_setWindowMovedCallback(object func=win_move_cb)
	return c_func(xRGFW_setWindowMovedCallback,{win_move_cb})
end function

public function window_resized_cb(atom win_ptr,object rect)
	printf(1,"Resized: x:%d y:%d w:%d h:%d",{rect})
	return 0
end function

atom resize_win_id = routine_id("window_resized_cb")
atom resize_win_cb = call_back(resize_win_id,{C_POINTER,RGFW_rect},C_VOID)

public constant xRGFW_setWindowResizedCallback = define_c_func(rgfw,"+RGFW_setWindowResizedCallback",{C_POINTER},C_POINTER)

public function RGFW_setWindowResizedCallback(object func=resize_win_cb)
	return c_func(xRGFW_setWindowResizedCallback,{func})
end function

public function window_quit_cb(atom win_ptr)
	puts(1,"Window is quitting")
	return 0
end function

atom quit_rid = routine_id("window_quit_cb")
atom quit_cb = call_back(quit_rid,{C_POINTER},C_VOID)

public constant xRGFW_setWindowQuitCallback = define_c_func(rgfw,"+RGFW_setWindowQuitCallback",{C_POINTER},C_POINTER)

public function RGFW_setWindowQuitCallback(object func=quit_cb)
	return c_func(xRGFW_setWindowQuitCallback,{func})
end function

public function mouse_moved_cb(atom win_ptr,object point,object vector)
	printf(1,"Mouse moved: x:%d, y:%d, dx:%d, dy:%d",{point[1],point[2],vector[1],vector[2]})
	return 0
end function

atom mm_id = routine_id("mouse_moved_cb")
atom mm_cb = call_back(mm_id,{C_POINTER,RGFW_point,RGFW_point},C_VOID)

public constant xRGFW_setMousePosCallback = define_c_func(rgfw,"+RGFW_setMousePosCallback",{C_POINTER},C_POINTER)

public function RGFW_setMousePosCallback(object func=mm_cb)
	return c_func(xRGFW_setMousePosCallback,{func})
end function

public function key_callback(atom win_ptr,atom key,atom keyChar,atom keyMod,atom pressed)
	printf(1,"Key event: key:%d, char:%d, mod:%d, pressed:%d",{key,keyChar,keyMod,pressed})
	return 0
end function

atom key_id = routine_id("key_callback")
atom key_cb = call_back(key_id,{C_POINTER,C_BYTE,C_BYTE,C_INT,C_INT},C_VOID)

public constant xRGFW_setKeyCallback = define_c_func(rgfw,"+RGFW_setKeyCallback",{C_POINTER},C_POINTER)

public function RGFW_setKeyCallback(object func=key_cb)
	return c_func(xRGFW_setKeyCallback,{func})
end function

public function mouse_button_cb(atom win_ptr,atom button,atom scroll,atom pressed)
	printf(1,"Mouse button: button:%d, scroll:%.2f, pressed:%d",{button,scroll,pressed})
	return 0
end function

atom mb_id = routine_id("mouse_button_cb")
atom mb_cb = call_back(mb_id,{C_POINTER,C_INT,C_DOUBLE,C_INT},C_VOID)

public constant xRGFW_setMouseButtonCallback = define_c_func(rgfw,"+RGFW_setMouseButtonCallback",{C_POINTER},C_POINTER)

public function RGFW_setMouseButtonCallback(object func=mb_cb)
	return c_func(xRGFW_setMouseButtonCallback,{func})
end function

public constant xRGFW_window_makeCurrent = define_c_proc(rgfw,"+RGFW_window_makeCurrent",{C_POINTER})

public procedure RGFW_window_makeCurrent(atom win)
	c_proc(xRGFW_window_makeCurrent,{win})
end procedure

public constant xRGFW_getCurrent = define_c_func(rgfw,"+RGFW_getCurrent",{},C_POINTER)

public function RGFW_getCurrent()
	return c_func(xRGFW_getCurrent,{})
end function

public constant xRGFW_window_swapBuffers = define_c_proc(rgfw,"+RGFW_window_swapBuffers",{C_POINTER})

public procedure RGFW_window_swapBuffers(atom win)
	c_proc(xRGFW_window_swapBuffers,{win})
end procedure

public constant xRGFW_window_swapInterval = define_c_proc(rgfw,"+RGFW_window_swapInterval",{C_POINTER,C_INT32})

public procedure RGFW_window_swapInterval(atom win,atom swap)
	c_proc(xRGFW_window_swapInterval,{win,swap})
end procedure

public constant xRGFW_window_swapBuffers_software = define_c_proc(rgfw,"+RGFW_window_swapBuffers_software",{C_POINTER})

public procedure RGFW_window_swapBuffers_software(atom win)
	c_proc(xRGFW_window_swapBuffers_software,{win})
end procedure

public constant xRGFW_window_initOpenGL = define_c_proc(rgfw,"+RGFW_window_initOpenGL",{C_POINTER})

public procedure RGFW_window_initOpenGL(atom win)
	c_proc(xRGFW_window_initOpenGL,{win})
end procedure

public constant xRGFW_window_freeOpenGL = define_c_proc(rgfw,"+RGFW_window_freeOpenGL",{C_POINTER})

public procedure RGFW_window_freeOpenGL(atom win)
	c_proc(xRGFW_window_freeOpenGL,{win})
end procedure

public enum type RGFW_glHints
	RGFW_glStencil = 0,  /*!< set stencil buffer bit size (8 by default) */
	RGFW_glSamples, /*!< set number of sampiling buffers (4 by default) */
	RGFW_glStereo, /*!< use GL_STEREO (GL_FALSE by default) */
	RGFW_glAuxBuffers, /*!< number of aux buffers (0 by default) */
	RGFW_glDoubleBuffer, /*!< request double buffering */
	RGFW_glRed, RGFW_glGreen, RGFW_glBlue, RGFW_glAlpha, /*!< set RGBA bit sizes */
	RGFW_glDepth,
	RGFW_glAccumRed, RGFW_glAccumGreen, RGFW_glAccumBlue,RGFW_glAccumAlpha, /*!< set accumulated RGBA bit sizes */
	RGFW_glSRGB, /*!< request sRGA */
	RGFW_glRobustness, /*!< request a robust context */
	RGFW_glDebug, /*!< request opengl debugging */
	RGFW_glNoError, /*!< request no opengl errors */
	RGFW_glReleaseBehavior,
	RGFW_glProfile,
	RGFW_glMajor, RGFW_glMinor,
	RGFW_glFinalHint = 32
end type

public enum type RGFW_glValue
	RGFW_releaseFlush = 0,
	RGFW_glReleaseNone,
	RGFW_glCore = 0,
	RGFW_elCompatibility,
	RGFW_glES
end type

public constant xRGFW_setGLHint = define_c_proc(rgfw,"+RGFW_setGLHint",{C_INT,C_INT32})

public procedure RGFW_setGLHint(atom hint,atom val)
	c_proc(xRGFW_setGLHint,{hint,val})
end procedure

public constant xRGFW_extensionSupported = define_c_func(rgfw,"+RGFW_extensionSupported",{C_STRING,C_SIZE_T},C_BOOL)

public function RGFW_extensionSupported(sequence ext,atom len)
	return c_func(xRGFW_extensionSupported,{ext,len})
end function

public constant xRGFW_getProcAddress = define_c_func(rgfw,"+RGFW_getProcAddress",{C_STRING},C_POINTER)

public function RGFW_getProcAddress(sequence procname)
	return c_func(xRGFW_getProcAddress,{procname})
end function

public constant xRGFW_window_makeCurrent_OpenGL = define_c_proc(rgfw,"+RGFW_window_makeCurrent_OpenGL",{C_POINTER})

public procedure RGFW_window_makeCurrent_OpenGL(atom win)
	c_proc(xRGFW_window_makeCurrent_OpenGL,{win})
end procedure

public constant xRGFW_window_swapBuffers_OpenGL = define_c_proc(rgfw,"+RGFW_window_swapBuffers_OpenGL",{C_POINTER})

public procedure RGFW_window_swapBuffers_OpenGL(atom win)
	c_proc(xRGFW_window_swapBuffers_OpenGL,{win})
end procedure

public constant xRGFW_getCurrent_OpenGL = define_c_func(rgfw,"+RGFW_getCurrent_OpenGL",{},C_POINTER)

public function RGFW_getCurrent_OpenGL()
	return c_func(xRGFW_getCurrent_OpenGL,{})
end function

public constant xRGFW_extensionSupportedPlatform = define_c_func(rgfw,"+RGFW_extensionSupportedPlatform",{C_STRING,C_SIZE_T},C_BOOL)

public function RGFW_extensionSupportedPlatform(sequence ext,atom len)
	return c_func(xRGFW_extensionSupportedPlatform,{ext,len})
end function

public constant xRGFW_getVKRequiredInstanceExtensions = define_c_func(rgfw,"+RGFW_getVKRequiredInstanceExtensions",{C_POINTER},C_STRING)

public function RGFW_getVKRequiredInstanceExtensions(atom count)

	atom pcount = allocate_data(sizeof(C_SIZE_T))
	
	if c_func(xRGFW_getVKRequiredInstanceExtensions,{pcount}) then
		count = peek_type(pcount,C_SIZE_T)
	end if
	
	free(pcount)
	
	return {count}
end function

public constant xRGFW_window_createDXSwapChain = define_c_func(rgfw,"+RGFW_window_createDXSwapChain",{C_POINTER,C_POINTER,C_POINTER,C_POINTER},C_INT)

public function RGFW_window_createDXSwapChain(atom win,atom pFactory,atom pDevice,atom swapChain)
	return c_func(xRGFW_window_createDXSwapChain,{win,pFactory,pDevice,swapChain})
end function

public constant xRGFW_getTime = define_c_func(rgfw,"+RGFW_getTime",{},C_DOUBLE)

public function RGFW_getTime()
	return c_func(xRGFW_getTime,{})
end function

public constant xRGFW_getTimeNS = define_c_func(rgfw,"+RGFW_getTimeNS",{},C_UINT64)

public function RGFW_getTimeNS()
	return c_func(xRGFW_getTimeNS,{})
end function

public constant xRGFW_sleep = define_c_proc(rgfw,"+RGFW_sleep",{C_UINT64})

public procedure RGFW_sleep(atom mili)
	c_proc(xRGFW_sleep,{mili})
end procedure

public constant xRGFW_setTime = define_c_proc(rgfw,"+RGFW_setTime",{C_DOUBLE})

public procedure RGFW_setTime(atom xtime)
	c_proc(xRGFW_setTime,{xtime})
end procedure

public constant xRGFW_getTimerValue = define_c_func(rgfw,"+RGFW_getTimerValue",{},C_UINT64)

public function RGFW_getTimerValue()
	return c_func(xRGFW_getTimerValue,{})
end function

public constant xRGFW_getTimerFreq = define_c_func(rgfw,"+RGFW_getTimerFreq",{},C_UINT64)

public function RGFW_getTimerFreq()
	return c_func(xRGFW_getTimerFreq,{})
end function

public constant RGFW_MAX_EVENTS = 32

public constant xRGFW_checkFPS = define_c_func(rgfw,"+RGFW_checkFPS",{C_DOUBLE,C_UINT32,C_UINT32},C_UINT32)

public function RGFW_checkFPS(atom startTime,atom frameCount,atom fpsCap)
	return c_func(xRGFW_checkFPS,{startTime,frameCount,fpsCap})
end function

public constant xRGFW_setRootWindow = define_c_proc(rgfw,"+RGFW_setRootWindow",{C_POINTER})

public procedure RGFW_setRootWindow(atom win)
	c_proc(xRGFW_setRootWindow,{win})
end procedure

public constant xRGFW_getRootWindow = define_c_func(rgfw,"+RGFW_getRootWindow",{},C_POINTER)

public function RGFW_getRootWindow()
	return c_func(xRGFW_getRootWindow,{})
end function

public constant xRGFW_eventQueuePush = define_c_proc(rgfw,"+RGFW_eventQueuePush",{C_INT})

public procedure RGFW_eventQueuePush(atom event)
	c_proc(xRGFW_eventQueuePush,{event})
end procedure

public constant xRGFW_eventQueuePop = define_c_func(rgfw,"+RGFW_eventQueuePop",{C_POINTER},C_POINTER)

public function RGFW_eventQueuePop(atom win)
	return c_func(xRGFW_eventQueuePop,{win})
end function

public enum type RGFW_ekey
	RGFW_keyNULL = 0,
RGFW_escape = 27,
RGFW_backtick = 96,
RGFW_0 = 48,
RGFW_1 = 49,
RGFW_2 = 50,
RGFW_3 = 51,
RGFW_4 = 52,
RGFW_5 = 53,
RGFW_6 = 54,
RGFW_7 = 55,
RGFW_8 = 56,
RGFW_9 = 57,
RGFW_minus = 45,
RGFW_equals = 61,
RGFW_backSpace = 8,
RGFW_tab = 9,
RGFW_space = 32,
RGFW_a = 97,
RGFW_b = 98,
RGFW_c = 99,
RGFW_d = 100,
RGFW_e = 101,
RGFW_f = 102,
RGFW_g = 103,
RGFW_h = 104,
RGFW_i = 105,
RGFW_j = 106,
RGFW_k = 107,
RGFW_l = 108,
RGFW_m = 109,
RGFW_n = 110,
RGFW_o = 111,
RGFW_p = 112,
RGFW_q = 113,
RGFW_r = 114,
RGFW_s = 115,
RGFW_t = 116,
RGFW_u = 117,
RGFW_v = 118,
RGFW_w = 119,
RGFW_x = 120,
RGFW_y = 121,
RGFW_z = 122,
RGFW_period = 46,
RGFW_comma = 44,
RGFW_slash = 47,
RGFW_bracket = 91,
RGFW_closeBracket = 93,
RGFW_semicolon = 59,
RGFW_apostrophe = 39,
RGFW_backSlash = 92,
RGFW_return = 10,
RGFW_enter = 10,
RGFW_delete = 127,

RGFW_F1 = 128,
RGFW_F2 = 129,
RGFW_F3 = 130,
RGFW_F4 = 131,
RGFW_F5 = 132,
RGFW_F6 = 133,
RGFW_F7 = 134,
RGFW_F8 = 135,
RGFW_F9 = 136,
RGFW_F10 = 137,
RGFW_F11 = 138,
RGFW_F12 = 139,

RGFW_capsLock = 140,
RGFW_shiftL = 141,
RGFW_controlL = 142,
RGFW_altL = 143,
RGFW_superL = 144,
RGFW_shiftR = 145,
RGFW_controlR = 146,
RGFW_altR = 147,
RGFW_superR = 148,
RGFW_up = 149,
RGFW_down = 150,
RGFW_left = 151,
RGFW_right = 152,
RGFW_insert = 153,
RGFW_end = 154,
RGFW_home = 155,
RGFW_pageUp = 156,
RGFW_pageDown = 157,

RGFW_numLock = 158,
RGFW_KP_Slash = 159,
RGFW_multiply = 160,
RGFW_KP_Minus = 161,
RGFW_KP_1 = 162,
RGFW_KP_2 = 163,
RGFW_KP_3 = 164,
RGFW_KP_4 = 165,
RGFW_KP_5 = 166,
RGFW_KP_6 = 167,
RGFW_KP_7 = 168,
RGFW_KP_8 = 169,
RGFW_KP_9 = 170,
RGFW_KP_0 = 171,
RGFW_KP_Period = 172,
RGFW_KP_Return = 173,
RGFW_scrollLock = 174,
RGFW_printScreen = 175,
RGFW_pause = 176,

RGFW_keyLast = 256

end type

public constant xRGFW_apiKeyToRGFW = define_c_func(rgfw,"+RGFW_apiKeyToRGFW",{C_UINT32},C_UINT32)

public function RGFW_apiKeyToRGFW(atom keycode)
	return c_func(xRGFW_apiKeyToRGFW,{keycode})
end function

public constant xRGFW_rgfwToApiKey = define_c_func(rgfw,"+RGFW_rgfwToApiKey",{C_UINT32},C_UINT32)

public function RGFW_rgfwToApiKey(atom keycode)
	return c_func(xRGFW_rgfwToApiKey,{keycode})
end function

public constant xRGFW_rgfwToKeyChar = define_c_func(rgfw,"+RGFW_rgfwToKeyChar",{C_UINT32},C_UINT8)

public function RGFW_rgfwToKeyChar(atom keycode)
	return c_func(xRGFW_rgfwToKeyChar,{keycode})
end function

public enum type RGFW_mouseIcons
	RGFW_mouseNormal = 0,
	RGFW_mouseArrow,
	RGFW_mouseIbeam,
	RGFW_mouseCrosshair,
	RGFW_mousePointingHand,
	RGFW_mouseResizeEW,
	RGFW_mouseResizeNS,
	RGFW_mouseResizeNWSE,
	RGFW_mouseResizeNESW,
	RGFW_mouseResizeAll,
	RGFW_mouseNotAllowed,
    RGFW_mouseIconFinal = 16
end type

public constant xRGFW_init = define_c_func(rgfw,"+RGFW_init",{},C_INT32)

public function RGFW_init()
	return c_func(xRGFW_init,{})
end function

public constant xRGFW_deinit = define_c_proc(rgfw,"+RGFW_deinit",{})

public procedure RGFW_deinit()
	c_proc(xRGFW_deinit,{})
end procedure

public constant xRGFW_init_heap = define_c_func(rgfw,"+RGFW_init_heap",{},C_POINTER)

public function RGFW_init_heap()
	return c_func(xRGFW_init_heap,{})
end function

public constant xRGFW_deinit_heap = define_c_proc(rgfw,"+RGFW_deinit_heap",{})

public procedure RGFW_deinit_heap()
	c_proc(xRGFW_deinit_heap,{})
end procedure

public constant RGFW_info = define_c_struct({
	C_POINTER, --root
	C_POINTER, --current
	C_INT32, --windowCount
	C_INT32, --eventLen
	C_POINTER, --hiddenMouse
	{RGFW_event,RGFW_MAX_EVENTS}, --events
	{C_UINT32,RGFW_keyLast}, --apiKeycodes
	{C_UINT8,256,512,128,256}, --keycodes
	C_STRING, --className
	C_BOOL, --useWaylandBool
	C_BOOL, --stopCheckEvents
	C_UINT64, --timeOffset
	C_STRING, --clipboard_data
	{C_CHAR,RGFW_MAX_PATH * RGFW_MAX_DROPS} --droppedFiles
})

public constant xRGFW_init_ptr = define_c_func(rgfw,"+RGFW_init_ptr",{C_POINTER},C_INT32)

public function RGFW_init_ptr(atom info)
	return c_func(xRGFW_init_ptr,{info})
end function

public constant xRGFW_deinit_ptr = define_c_proc(rgfw,"+RGFW_deinit_ptr",{C_POINTER})

public procedure RGFW_deinit_ptr(atom info)
	c_proc(xRGFW_deinit_ptr,{info})
end procedure

public constant xRGFW_setInfo = define_c_proc(rgfw,"+RGFW_setInfo",{C_POINTER})

public procedure RGFW_setInfo(atom info)
	c_proc(xRGFW_setInfo,{info})
end procedure

public constant xRGFW_getInfo = define_c_func(rgfw,"+RGFW_getInfo",{},C_POINTER)

public function RGFW_getInfo()
	return c_func(xRGFW_getInfo,{})
end function
­309.0