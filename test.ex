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
­35.0