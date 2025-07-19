# EuRGFW

EuRGFW is a wrapper of RGFW for the openEuphoria programming language. RGFW can serve as an alternative to GLFW. 

NOTE: Use rgfw.dll for 64-bit euphoria and rgfw32.dll for 32-bit euphoria. 

# LICENSE

Copyright (c) <2025> <Icy_Viking>

This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software.

Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software. This notice may not be removed or altered from any source distribution.

# EXAMPLE

```euphoria
include std/ffi.e 
include std/machine.e 
 
include rgfw.e 
include opengl.e 
 
--RGFW_setClassName("Example") 
 
atom win = RGFW_createWindow("Test Win",{100,100,640,480},RGFW_windowCenter) 
 
while not RGFW_window_shouldClose(win) do 
 
	while RGFW_window_checkEvent(win) do 
		if win = RGFW_quit then 
			exit 
		end if 
		if RGFW_isPressed(win,RGFW_escape) then 
			exit 
		end if 
	end while 
	 
	glClearColor(0.1,0.1,0.1,1.0) 
	glClear(GL_COLOR_BUFFER_BIT) 
	 
	glBegin(GL_TRIANGLES) 
	glColor3f(1.0,0.0,0.0) glVertex2f(-0.6,-0.75) 
	glColor3f(0.0,1.0,0.0) glVertex2f(0.6,-0.75) 
	glColor3f(0.0,0.0,1.0) glVertex2f(0.0,0.75) 
	glEnd() 
	 
	RGFW_window_swapBuffers(win) 
	 
end while 
 
RGFW_window_close(win) 
```
