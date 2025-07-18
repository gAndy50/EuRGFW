-----------------------------------
--EuOpenGL
--Written by Andy P.
--OpenGL wrapper for OpenEuphoria
--Copyright (c) 2025
------------------------------------
include std/ffi.e
include std/machine.e
include std/os.e

public atom gl

ifdef WINDOWS then
	gl = open_dll("opengl32.dll")
	elsifdef LINUX or FREEBSD then
	gl = open_dll("libGL.so")
end ifdef

if gl = -1 then
	puts(1,"Failed to load openGL!\n")
	abort(0)
end if

public constant GLenum = C_UINT
public constant GLboolean = C_UCHAR
public constant GLbitfield = C_UINT
public constant GLbyte = C_CHAR
public constant GLshort = C_SHORT
public constant GLint = C_INT
public constant GLsizei = C_INT
public constant GLubyte = C_UCHAR
public constant GLushort = C_USHORT
public constant GLuint = C_UINT
public constant GLfloat = C_FLOAT
public constant GLclampf = C_FLOAT
public constant GLdouble = C_DOUBLE
public constant GLclampd = C_DOUBLE
public constant GLvoid = C_VOID

printf(1,"%d",{gl}) --used to make sure DLL is being loaded

public constant GL_VERSION_1_1 = 1

--Flags
public constant GL_ACCUM =0x0100
public constant GL_LOAD =0x0101
public constant GL_RETURN =0x0102
public constant GL_MULT =0x0103
public constant GL_ADD =0x0104

public constant GL_NEVER =0x0200
public constant GL_LESS =0x0201
public constant GL_EQUAL =0x0202
public constant GL_LEQUAL =0x0203
public constant GL_GREATER =0x0204
public constant GL_NOTEQUAL =0x0205
public constant GL_GEQUAL =0x0206
public constant GL_ALWAYS =0x0207

public constant GL_CURRENT_BIT =0x00000001
public constant GL_POINT_BIT =0x00000002
public constant GL_LINE_BIT =0x00000004
public constant GL_POLYGON_BIT =0x00000008
public constant GL_POLYGON_STIPPLE_BIT =0x00000010
public constant GL_PIXEL_MODE_BIT =0x00000020
public constant GL_LIGHTING_BIT =0x00000040
public constant GL_FOG_BIT =0x00000080
public constant GL_DEPTH_BUFFER_BIT =0x00000100
public constant GL_ACCUM_BUFFER_BIT =0x00000200
public constant GL_STENCIL_BUFFER_BIT =0x00000400
public constant GL_VIEWPORT_BIT =0x00000800
public constant GL_TRANSFORM_BIT =0x00001000
public constant GL_ENABLE_BIT =0x00002000
public constant GL_COLOR_BUFFER_BIT =0x00004000
public constant GL_HINT_BIT =0x00008000
public constant GL_EVAL_BIT =0x00010000
public constant GL_LIST_BIT =0x00020000
public constant GL_TEXTURE_BIT =0x00040000
public constant GL_SCISSOR_BIT =0x00080000
public constant GL_ALL_ATTRIB_BITS =0x000fffff

public constant GL_POINTS =0x0000
public constant GL_LINES =0x0001
public constant GL_LINE_LOOP =0x0002
public constant GL_LINE_STRIP =0x0003
public constant GL_TRIANGLES =0x0004
public constant GL_TRIANGLE_STRIP =0x0005
public constant GL_TRIANGLE_FAN =0x0006
public constant GL_QUADS =0x0007
public constant GL_QUAD_STRIP =0x0008
public constant GL_POLYGON =0x0009

public constant GL_ZERO =0
public constant GL_ONE =1
public constant GL_SRC_COLOR =0x0300
public constant GL_ONE_MINUS_SRC_COLOR =0x0301
public constant GL_SRC_ALPHA =0x0302
public constant GL_ONE_MINUS_SRC_ALPHA =0x0303
public constant GL_DST_ALPHA =0x0304
public constant GL_ONE_MINUS_DST_ALPHA =0x0305

public constant GL_DST_COLOR =0x0306
public constant GL_ONE_MINUS_DST_COLOR =0x0307
public constant GL_SRC_ALPHA_SATURATE =0x0308

public constant GL_TRUE =1
public constant GL_FALSE =0

public constant GL_CLIP_PLANE0 =0x3000
public constant GL_CLIP_PLANE1 =0x3001
public constant GL_CLIP_PLANE2 =0x3002
public constant GL_CLIP_PLANE3 =0x3003
public constant GL_CLIP_PLANE4 =0x3004
public constant GL_CLIP_PLANE5 =0x3005

public constant GL_BYTE =0x1400
public constant GL_UNSIGNED_BYTE =0x1401
public constant GL_SHORT =0x1402
public constant GL_UNSIGNED_SHORT =0x1403
public constant GL_INT =0x1404
public constant GL_UNSIGNED_INT =0x1405
public constant GL_FLOAT =0x1406
public constant GL_2_BYTES= 0x1407
public constant GL_3_BYTES =0x1408
public constant GL_4_BYTES =0x1409
public constant GL_DOUBLE =0x140A

public constant GL_NONE =0
public constant GL_FRONT_LEFT =0x0400
public constant GL_FRONT_RIGHT =0x0401
public constant GL_BACK_LEFT =0x0402
public constant GL_BACK_RIGHT =0x0403
public constant GL_FRONT =0x0404
public constant GL_BACK =0x0405
public constant GL_LEFT =0x0406
public constant GL_RIGHT =0x0407
public constant GL_FRONT_AND_BACK =0x0408
public constant GL_AUX0 =0x0409
public constant GL_AUX1 =0x040A
public constant GL_AUX2 =0x040B
public constant GL_AUX3 =0x040C

public constant GL_NO_ERROR =0
public constant GL_INVALID_ENUM =0x0500
public constant GL_INVALID_VALUE =0x0501
public constant GL_INVALID_OPERATION =0x0502
public constant GL_STACK_OVERFLOW =0x0503
public constant GL_STACK_UNDERFLOW =0x0504
public constant GL_OUT_OF_MEMORY =0x0505

public constant GL_2D =0x0600
public constant GL_3D =0x0601
public constant GL_3D_COLOR =0x0602
public constant GL_3D_COLOR_TEXTURE =0x0603
public constant GL_4D_COLOR_TEXTURE =0x0604

public constant GL_PASS_THROUGH_TOKEN =0x0700
public constant GL_POINT_TOKEN =0x0701
public constant GL_LINE_TOKEN =0x0702
public constant GL_POLYGON_TOKEN =0x0703
public constant GL_BITMAP_TOKEN =0x0704
public constant GL_DRAW_PIXEL_TOKEN =0x0705
public constant GL_COPY_PIXEL_TOKEN =0x0706
public constant GL_LINE_RESET_TOKEN =0x0707

public constant GL_EXP =0x0800
public constant GL_EXP2 =0x0801

public constant GL_CW =0x0900
public constant GL_CCW =0x0901

public constant GL_COEFF =0x0A00
public constant GL_ORDER =0x0A01
public constant GL_DOMAIN =0x0A02

public constant GL_CURRENT_COLOR =0x0B00
public constant GL_CURRENT_INDEX =0x0B01
public constant GL_CURRENT_NORMAL =0x0B02
public constant GL_CURRENT_TEXTURE_COORDS =0x0B03
public constant GL_CURRENT_RASTER_COLOR =0x0B04
public constant GL_CURRENT_RASTER_INDEX =0x0B05
public constant GL_CURRENT_RASTER_TEXTURE_COORDS =0x0B06
public constant GL_CURRENT_RASTER_POSITION =0x0B07
public constant GL_CURRENT_RASTER_POSITION_VALID =0x0B08
public constant GL_CURRENT_RASTER_DISTANCE =0x0B09
public constant GL_POINT_SMOOTH =0x0B10
public constant GL_POINT_SIZE =0x0B11
public constant GL_POINT_SIZE_RANGE =0x0B12
public constant GL_POINT_SIZE_GRANULARITY =0x0B13
public constant GL_LINE_SMOOTH =0x0B20
public constant GL_LINE_WIDTH =0x0B21
public constant GL_LINE_WIDTH_RANGE =0x0B22
public constant GL_LINE_WIDTH_GRANULARITY =0x0B23
public constant GL_LINE_STIPPLE =0x0B24
public constant GL_LINE_STIPPLE_PATTERN =0x0B25
public constant GL_LINE_STIPPLE_REPEAT =0x0B26
public constant GL_LIST_MODE =0x0B30
public constant GL_MAX_LIST_NESTING =0x0B31
public constant GL_LIST_BASE =0x0B32
public constant GL_LIST_INDEX =0x0B33
public constant GL_POLYGON_MODE =0x0B40
public constant GL_POLYGON_SMOOTH =0x0B41
public constant GL_POLYGON_STIPPLE =0x0B42
public constant GL_EDGE_FLAG =0x0B43
public constant GL_CULL_FACE =0x0B44
public constant GL_CULL_FACE_MODE =0x0B45
public constant GL_FRONT_FACE =0x0B46
public constant GL_LIGHTING =0x0B50
public constant GL_LIGHT_MODEL_LOCAL_VIEWER =0x0B51
public constant GL_LIGHT_MODEL_TWO_SIDE =0x0B52
public constant GL_LIGHT_MODEL_AMBIENT =0x0B53
public constant GL_SHADE_MODEL =0x0B54
public constant GL_COLOR_MATERIAL_FACE =0x0B55
public constant GL_COLOR_MATERIAL_PARAMETER =0x0B56
public constant GL_COLOR_MATERIAL =0x0B57
public constant GL_FOG =0x0B60
public constant GL_FOG_INDEX =0x0B61
public constant GL_FOG_DENSITY =0x0B62
public constant GL_FOG_START =0x0B63
public constant GL_FOG_END =0x0B64
public constant GL_FOG_MODE =0x0B65
public constant GL_FOG_COLOR =0x0B66
public constant GL_DEPTH_RANGE =0x0B70
public constant GL_DEPTH_TEST =0x0B71
public constant GL_DEPTH_WRITEMASK =0x0B72
public constant GL_DEPTH_CLEAR_VALUE =0x0B73
public constant GL_DEPTH_FUNC =0x0B74
public constant GL_ACCUM_CLEAR_VALUE =0x0B80
public constant GL_STENCIL_TEST =0x0B90
public constant GL_STENCIL_CLEAR_VALUE =0x0B91
public constant GL_STENCIL_FUNC =0x0B92
public constant GL_STENCIL_VALUE_MASK =0x0B93
public constant GL_STENCIL_FAIL =0x0B94
public constant GL_STENCIL_PASS_DEPTH_FAIL =0x0B95
public constant GL_STENCIL_PASS_DEPTH_PASS =0x0B96
public constant GL_STENCIL_REF =0x0B97
public constant GL_STENCIL_WRITEMASK =0x0B98
public constant GL_MATRIX_MODE =0x0BA0
public constant GL_NORMALIZE =0x0BA1
public constant GL_VIEWPORT =0x0BA2
public constant GL_MODELVIEW_STACK_DEPTH =0x0BA3
public constant GL_PROJECTION_STACK_DEPTH =0x0BA4
public constant GL_TEXTURE_STACK_DEPTH =0x0BA5
public constant GL_MODELVIEW_MATRIX =0x0BA6
public constant GL_PROJECTION_MATRIX =0x0BA7
public constant GL_TEXTURE_MATRIX =0x0BA8
public constant GL_ATTRIB_STACK_DEPTH =0x0BB0
public constant GL_CLIENT_ATTRIB_STACK_DEPTH =0x0BB1
public constant GL_ALPHA_TEST =0x0BC0
public constant GL_ALPHA_TEST_FUNC =0x0BC1
public constant GL_ALPHA_TEST_REF =0x0BC2
public constant GL_DITHER =0x0BD0
public constant GL_BLEND_DST =0x0BE0
public constant GL_BLEND_SRC =0x0BE1
public constant GL_BLEND =0x0BE2
public constant GL_LOGIC_OP_MODE =0x0BF0
public constant GL_INDEX_LOGIC_OP =0x0BF1
public constant GL_COLOR_LOGIC_OP =0x0BF2
public constant GL_AUX_BUFFERS =0x0C00
public constant GL_DRAW_BUFFER =0x0C01
public constant GL_READ_BUFFER =0x0C02
public constant GL_SCISSOR_BOX =0x0C10
public constant GL_SCISSOR_TEST =0x0C11
public constant GL_INDEX_CLEAR_VALUE =0x0C20
public constant GL_INDEX_WRITEMASK =0x0C21
public constant GL_COLOR_CLEAR_VALUE =0x0C22
public constant GL_COLOR_WRITEMASK =0x0C23
public constant GL_INDEX_MODE =0x0C30
public constant GL_RGBA_MODE =0x0C31
public constant GL_DOUBLEBUFFER =0x0C32
public constant GL_STEREO =0x0C33
public constant GL_RENDER_MODE =0x0C40
public constant GL_PERSPECTIVE_CORRECTION_HINT= 0x0C50
public constant GL_POINT_SMOOTH_HINT =0x0C51
public constant GL_LINE_SMOOTH_HINT =0x0C52
public constant GL_POLYGON_SMOOTH_HINT= 0x0C53
public constant GL_FOG_HINT =0x0C54
public constant GL_TEXTURE_GEN_S =0x0C60
public constant GL_TEXTURE_GEN_T =0x0C61
public constant GL_TEXTURE_GEN_R =0x0C62
public constant GL_TEXTURE_GEN_Q =0x0C63
public constant GL_PIXEL_MAP_I_TO_I =0x0C70
public constant GL_PIXEL_MAP_S_TO_S =0x0C71
public constant GL_PIXEL_MAP_I_TO_R =0x0C72
public constant GL_PIXEL_MAP_I_TO_G =0x0C73
public constant GL_PIXEL_MAP_I_TO_B =0x0C74
public constant GL_PIXEL_MAP_I_TO_A =0x0C75
public constant GL_PIXEL_MAP_R_TO_R =0x0C76
public constant GL_PIXEL_MAP_G_TO_G =0x0C77
public constant GL_PIXEL_MAP_B_TO_B =0x0C78
public constant GL_PIXEL_MAP_A_TO_A =0x0C79
public constant GL_PIXEL_MAP_I_TO_I_SIZE =0x0CB0
public constant GL_PIXEL_MAP_S_TO_S_SIZE =0x0CB1
public constant GL_PIXEL_MAP_I_TO_R_SIZE =0x0CB2
public constant GL_PIXEL_MAP_I_TO_G_SIZE =0x0CB3
public constant GL_PIXEL_MAP_I_TO_B_SIZE =0x0CB4
public constant GL_PIXEL_MAP_I_TO_A_SIZE =0x0CB5
public constant GL_PIXEL_MAP_R_TO_R_SIZE =0x0CB6
public constant GL_PIXEL_MAP_G_TO_G_SIZE =0x0CB7
public constant GL_PIXEL_MAP_B_TO_B_SIZE =0x0CB8
public constant GL_PIXEL_MAP_A_TO_A_SIZE =0x0CB9
public constant GL_UNPACK_SWAP_BYTES =0x0CF0
public constant GL_UNPACK_LSB_FIRST =0x0CF1
public constant GL_UNPACK_ROW_LENGTH =0x0CF2
public constant GL_UNPACK_SKIP_ROWS =0x0CF3
public constant GL_UNPACK_SKIP_PIXELS =0x0CF4
public constant GL_UNPACK_ALIGNMENT =0x0CF5
public constant GL_PACK_SWAP_BYTES =0x0D00
public constant GL_PACK_LSB_FIRST =0x0D01
public constant GL_PACK_ROW_LENGTH =0x0D02
public constant GL_PACK_SKIP_ROWS =0x0D03
public constant GL_PACK_SKIP_PIXELS =0x0D04
public constant GL_PACK_ALIGNMENT =0x0D05
public constant GL_MAP_COLOR =0x0D10
public constant GL_MAP_STENCIL =0x0D11
public constant GL_INDEX_SHIFT =0x0D12
public constant GL_INDEX_OFFSET =0x0D13
public constant GL_RED_SCALE =0x0D14
public constant GL_RED_BIAS =0x0D15
public constant GL_ZOOM_X =0x0D16
public constant GL_ZOOM_Y =0x0D17
public constant GL_GREEN_SCALE =0x0D18
public constant GL_GREEN_BIAS =0x0D19
public constant GL_BLUE_SCALE =0x0D1A
public constant GL_BLUE_BIAS =0x0D1B
public constant GL_ALPHA_SCALE =0x0D1C
public constant GL_ALPHA_BIAS =0x0D1D
public constant GL_DEPTH_SCALE =0x0D1E
public constant GL_DEPTH_BIAS =0x0D1F
public constant GL_MAX_EVAL_ORDER =0x0D30
public constant GL_MAX_LIGHTS =0x0D31
public constant GL_MAX_CLIP_PLANES =0x0D32
public constant GL_MAX_TEXTURE_SIZE =0x0D33
public constant GL_MAX_PIXEL_MAP_TABLE =0x0D34
public constant GL_MAX_ATTRIB_STACK_DEPTH =0x0D35
public constant GL_MAX_MODELVIEW_STACK_DEPTH =0x0D36
public constant GL_MAX_NAME_STACK_DEPTH =0x0D37
public constant GL_MAX_PROJECTION_STACK_DEPTH =0x0D38
public constant GL_MAX_TEXTURE_STACK_DEPTH =0x0D39
public constant GL_MAX_VIEWPORT_DIMS =0x0D3A
public constant GL_MAX_CLIENT_ATTRIB_STACK_DEPTH =0x0D3B
public constant GL_SUBPIXEL_BITS =0x0D50
public constant GL_INDEX_BITS =0x0D51
public constant GL_RED_BITS =0x0D52
public constant GL_GREEN_BITS =0x0D53
public constant GL_BLUE_BITS =0x0D54
public constant GL_ALPHA_BITS =0x0D55
public constant GL_DEPTH_BITS =0x0D56
public constant GL_STENCIL_BITS =0x0D57
public constant GL_ACCUM_RED_BITS =0x0D58
public constant GL_ACCUM_GREEN_BITS =0x0D59
public constant GL_ACCUM_BLUE_BITS =0x0D5A
public constant GL_ACCUM_ALPHA_BITS =0x0D5B
public constant GL_NAME_STACK_DEPTH =0x0D70
public constant GL_AUTO_NORMAL =0x0D80
public constant GL_MAP1_COLOR_4 =0x0D90
public constant GL_MAP1_INDEX =0x0D91
public constant GL_MAP1_NORMAL =0x0D92
public constant GL_MAP1_TEXTURE_COORD_1 =0x0D93
public constant GL_MAP1_TEXTURE_COORD_2 =0x0D94
public constant GL_MAP1_TEXTURE_COORD_3 =0x0D95
public constant GL_MAP1_TEXTURE_COORD_4 =0x0D96
public constant GL_MAP1_VERTEX_3 =0x0D97
public constant GL_MAP1_VERTEX_4 =0x0D98
public constant GL_MAP2_COLOR_4 =0x0DB0
public constant GL_MAP2_INDEX =0x0DB1
public constant GL_MAP2_NORMAL =0x0DB2
public constant GL_MAP2_TEXTURE_COORD_1 =0x0DB3
public constant GL_MAP2_TEXTURE_COORD_2 =0x0DB4
public constant GL_MAP2_TEXTURE_COORD_3 =0x0DB5
public constant GL_MAP2_TEXTURE_COORD_4 =0x0DB6
public constant GL_MAP2_VERTEX_3 =0x0DB7
public constant GL_MAP2_VERTEX_4 =0x0DB8
public constant GL_MAP1_GRID_DOMAIN =0x0DD0
public constant GL_MAP1_GRID_SEGMENTS= 0x0DD1
public constant GL_MAP2_GRID_DOMAIN =0x0DD2
public constant GL_MAP2_GRID_SEGMENTS= 0x0DD3
public constant GL_TEXTURE_1D =0x0DE0
public constant GL_TEXTURE_2D =0x0DE1
public constant GL_FEEDBACK_BUFFER_POINTER= 0x0DF0
public constant GL_FEEDBACK_BUFFER_SIZE =0x0DF1
public constant GL_FEEDBACK_BUFFER_TYPE =0x0DF2
public constant GL_SELECTION_BUFFER_POINTER =0x0DF3
public constant GL_SELECTION_BUFFER_SIZE =0x0DF4

public constant GL_TEXTURE_WIDTH =0x1000
public constant GL_TEXTURE_HEIGHT =0x1001
public constant GL_TEXTURE_INTERNAL_FORMAT =0x1003
public constant GL_TEXTURE_BORDER_COLOR =0x1004
public constant GL_TEXTURE_BORDER =0x1005

public constant GL_DONT_CARE =0x1100
public constant GL_FASTEST =0x1101
public constant GL_NICEST =0x1102

public constant GL_LIGHT0 =0x4000
public constant GL_LIGHT1 =0x4001
public constant GL_LIGHT2 =0x4002
public constant GL_LIGHT3 =0x4003
public constant GL_LIGHT4 =0x4004
public constant GL_LIGHT5 =0x4005
public constant GL_LIGHT6 =0x4006
public constant GL_LIGHT7 =0x4007

public constant GL_AMBIENT =0x1200
public constant GL_DIFFUSE =0x1201
public constant GL_SPECULAR =0x1202
public constant GL_POSITION =0x1203
public constant GL_SPOT_DIRECTION =0x1204
public constant GL_SPOT_EXPONENT =0x1205
public constant GL_SPOT_CUTOFF =0x1206
public constant GL_CONSTANT_ATTENUATION =0x1207
public constant GL_LINEAR_ATTENUATION =0x1208
public constant GL_QUADRATIC_ATTENUATION =0x1209

public constant GL_COMPILE =0x1300
public constant GL_COMPILE_AND_EXECUTE =0x1301

public constant GL_CLEAR =0x1500
public constant GL_AND =0x1501
public constant GL_AND_REVERSE =0x1502
public constant GL_COPY =0x1503
public constant GL_AND_INVERTED= 0x1504
public constant GL_NOOP =0x1505
public constant GL_XOR =0x1506
public constant GL_OR =0x1507
public constant GL_NOR =0x1508
public constant GL_EQUIV =0x1509
public constant GL_INVERT =0x150A
public constant GL_OR_REVERSE =0x150B
public constant GL_COPY_INVERTED =0x150C
public constant GL_OR_INVERTED =0x150D
public constant GL_NAND =0x150E
public constant GL_SET =0x150F

public constant GL_EMISSION =0x1600
public constant GL_SHININESS =0x1601
public constant GL_AMBIENT_AND_DIFFUSE =0x1602
public constant GL_COLOR_INDEXES =0x1603

public constant GL_MODELVIEW =0x1700
public constant GL_PROJECTION =0x1701
public constant GL_TEXTURE =0x1702

public constant GL_COLOR =0x1800
public constant GL_DEPTH =0x1801
public constant GL_STENCIL =0x1802

public constant GL_COLOR_INDEX =0x1900
public constant GL_STENCIL_INDEX =0x1901
public constant GL_DEPTH_COMPONENT =0x1902
public constant GL_RED =0x1903
public constant GL_GREEN =0x1904
public constant GL_BLUE =0x1905
public constant GL_ALPHA =0x1906
public constant GL_RGB =0x1907
public constant GL_RGBA =0x1908
public constant GL_LUMINANCE =0x1909
public constant GL_LUMINANCE_ALPHA =0x190A

public constant GL_BITMAP =0x1A00

public constant GL_POINT =0x1B00
public constant GL_LINE =0x1B01
public constant GL_FILL =0x1B02

public constant GL_RENDER =0x1C00
public constant GL_FEEDBACK =0x1C01
public constant GL_SELECT =0x1C02

public constant GL_FLAT =0x1D00
public constant GL_SMOOTH =0x1D01

public constant GL_KEEP =0x1E00
public constant GL_REPLACE =0x1E01
public constant GL_INCR =0x1E02
public constant GL_DECR =0x1E03

public constant GL_VENDOR =0x1F00
public constant GL_RENDERER =0x1F01
public constant GL_VERSION =0x1F02
public constant GL_EXTENSIONS =0x1F03

public constant GL_S =0x2000
public constant GL_T= 0x2001
public constant GL_R =0x2002
public constant GL_Q =0x2003

public constant GL_MODULATE =0x2100
public constant GL_DECAL =0x2101

public constant GL_TEXTURE_ENV_MODE =0x2200
public constant GL_TEXTURE_ENV_COLOR =0x2201

public constant GL_TEXTURE_ENV =0x2300

public constant GL_EYE_LINEAR =0x2400
public constant GL_OBJECT_LINEAR =0x2401
public constant GL_SPHERE_MAP =0x2402

public constant GL_TEXTURE_GEN_MODE =0x2500
public constant GL_OBJECT_PLANE =0x2501
public constant GL_EYE_PLANE =0x2502

public constant GL_NEAREST =0x2600
public constant GL_LINEAR =0x2601

public constant GL_NEAREST_MIPMAP_NEAREST =0x2700
public constant GL_LINEAR_MIPMAP_NEAREST =0x2701
public constant GL_NEAREST_MIPMAP_LINEAR =0x2702
public constant GL_LINEAR_MIPMAP_LINEAR =0x2703

public constant GL_TEXTURE_MAG_FILTER =0x2800
public constant GL_TEXTURE_MIN_FILTER =0x2801
public constant GL_TEXTURE_WRAP_S =0x2802
public constant GL_TEXTURE_WRAP_T =0x2803

public constant GL_CLAMP =0x2900
public constant GL_REPEAT= 0x2901

public constant GL_CLIENT_PIXEL_STORE_BIT =0x00000001
public constant GL_CLIENT_VERTEX_ARRAY_BIT =0x00000002
public constant GL_CLIENT_ALL_ATTRIB_BITS =0xffffffff

public constant GL_POLYGON_OFFSET_FACTOR =0x8038
public constant GL_POLYGON_OFFSET_UNITS =0x2A00
public constant GL_POLYGON_OFFSET_POINT =0x2A01
public constant GL_POLYGON_OFFSET_LINE =0x2A02
public constant GL_POLYGON_OFFSET_FILL =0x8037

public constant GL_ALPHA4 =0x803B
public constant GL_ALPHA8 =0x803C
public constant GL_ALPHA12 =0x803D
public constant GL_ALPHA16 =0x803E
public constant GL_LUMINANCE4 =0x803F
public constant GL_LUMINANCE8 =0x8040
public constant GL_LUMINANCE12 =0x8041
public constant GL_LUMINANCE16 =0x8042
public constant GL_LUMINANCE4_ALPHA4 =0x8043
public constant GL_LUMINANCE6_ALPHA2 =0x8044
public constant GL_LUMINANCE8_ALPHA8 =0x8045
public constant GL_LUMINANCE12_ALPHA4 =0x8046
public constant GL_LUMINANCE12_ALPHA12 =0x8047
public constant GL_LUMINANCE16_ALPHA16 =0x8048
public constant GL_INTENSITY =0x8049
public constant GL_INTENSITY4 =0x804A
public constant GL_INTENSITY8 =0x804B
public constant GL_INTENSITY12 =0x804C
public constant GL_INTENSITY16 =0x804D
public constant GL_R3_G3_B2 =0x2A10
public constant GL_RGB4 =0x804F
public constant GL_RGB5 =0x8050
public constant GL_RGB8 =0x8051
public constant GL_RGB10 =0x8052
public constant GL_RGB12 =0x8053
public constant GL_RGB16 =0x8054
public constant GL_RGBA2 =0x8055
public constant GL_RGBA4 =0x8056
public constant GL_RGB5_A1 =0x8057
public constant GL_RGBA8 =0x8058
public constant GL_RGB10_A2 =0x8059
public constant GL_RGBA12 =0x805A
public constant GL_RGBA16 =0x805B
public constant GL_TEXTURE_RED_SIZE =0x805C
public constant GL_TEXTURE_GREEN_SIZE =0x805D
public constant GL_TEXTURE_BLUE_SIZE =0x805E
public constant GL_TEXTURE_ALPHA_SIZE= 0x805F
public constant GL_TEXTURE_LUMINANCE_SIZE= 0x8060
public constant GL_TEXTURE_INTENSITY_SIZE =0x8061
public constant GL_PROXY_TEXTURE_1D= 0x8063
public constant GL_PROXY_TEXTURE_2D =0x8064

public constant GL_TEXTURE_PRIORITY =0x8066
public constant GL_TEXTURE_RESIDENT =0x8067
public constant GL_TEXTURE_BINDING_1D= 0x8068
public constant GL_TEXTURE_BINDING_2D= 0x8069

public constant GL_VERTEX_ARRAY =0x8074
public constant GL_NORMAL_ARRAY =0x8075
public constant GL_COLOR_ARRAY =0x8076
public constant GL_INDEX_ARRAY =0x8077
public constant GL_TEXTURE_COORD_ARRAY= 0x8078
public constant GL_EDGE_FLAG_ARRAY =0x8079
public constant GL_VERTEX_ARRAY_SIZE= 0x807A
public constant GL_VERTEX_ARRAY_TYPE =0x807B
public constant GL_VERTEX_ARRAY_STRIDE= 0x807C
public constant GL_NORMAL_ARRAY_TYPE =0x807E
public constant GL_NORMAL_ARRAY_STRIDE= 0x807F
public constant GL_COLOR_ARRAY_SIZE =0x8081
public constant GL_COLOR_ARRAY_TYPE =0x8082
public constant GL_COLOR_ARRAY_STRIDE= 0x8083
public constant GL_INDEX_ARRAY_TYPE =0x8085
public constant GL_INDEX_ARRAY_STRIDE= 0x8086
public constant GL_TEXTURE_COORD_ARRAY_SIZE= 0x8088
public constant GL_TEXTURE_COORD_ARRAY_TYPE =0x8089
public constant GL_TEXTURE_COORD_ARRAY_STRIDE= 0x808A
public constant GL_EDGE_FLAG_ARRAY_STRIDE =0x808C
public constant GL_VERTEX_ARRAY_POINTER =0x808E
public constant GL_NORMAL_ARRAY_POINTER =0x808F
public constant GL_COLOR_ARRAY_POINTER =0x8090
public constant GL_INDEX_ARRAY_POINTER =0x8091
public constant GL_TEXTURE_COORD_ARRAY_POINTER= 0x8092
public constant GL_EDGE_FLAG_ARRAY_POINTER =0x8093
public constant GL_V2F =0x2A20
public constant GL_V3F =0x2A21
public constant GL_C4UB_V2F =0x2A22
public constant GL_C4UB_V3F =0x2A23
public constant GL_C3F_V3F =0x2A24
public constant GL_N3F_V3F =0x2A25
public constant GL_C4F_N3F_V3F =0x2A26
public constant GL_T2F_V3F =0x2A27
public constant GL_T4F_V4F =0x2A28
public constant GL_T2F_C4UB_V3F =0x2A29
public constant GL_T2F_C3F_V3F =0x2A2A
public constant GL_T2F_N3F_V3F =0x2A2B
public constant GL_T2F_C4F_N3F_V3F =0x2A2C
public constant GL_T4F_C4F_N3F_V4F =0x2A2D

public constant GL_EXT_vertex_array =1
public constant GL_EXT_bgra =1
public constant GL_EXT_paletted_texture =1
public constant GL_WIN_swap_hint= 1
public constant GL_WIN_draw_range_elements= 1

public constant GL_VERTEX_ARRAY_EXT =0x8074
public constant GL_NORMAL_ARRAY_EXT =0x8075
public constant GL_COLOR_ARRAY_EXT =0x8076
public constant GL_INDEX_ARRAY_EXT =0x8077
public constant GL_TEXTURE_COORD_ARRAY_EXT= 0x8078
public constant GL_EDGE_FLAG_ARRAY_EXT =0x8079
public constant GL_VERTEX_ARRAY_SIZE_EXT= 0x807A
public constant GL_VERTEX_ARRAY_TYPE_EXT =0x807B
public constant GL_VERTEX_ARRAY_STRIDE_EXT= 0x807C
public constant GL_VERTEX_ARRAY_COUNT_EXT =0x807D
public constant GL_NORMAL_ARRAY_TYPE_EXT =0x807E
public constant GL_NORMAL_ARRAY_STRIDE_EXT= 0x807F
public constant GL_NORMAL_ARRAY_COUNT_EXT =0x8080
public constant GL_COLOR_ARRAY_SIZE_EXT =0x8081
public constant GL_COLOR_ARRAY_TYPE_EXT =0x8082
public constant GL_COLOR_ARRAY_STRIDE_EXT= 0x8083
public constant GL_COLOR_ARRAY_COUNT_EXT =0x8084
public constant GL_INDEX_ARRAY_TYPE_EXT =0x8085
public constant GL_INDEX_ARRAY_STRIDE_EXT= 0x8086
public constant GL_INDEX_ARRAY_COUNT_EXT =0x8087
public constant GL_TEXTURE_COORD_ARRAY_SIZE_EXT= 0x8088
public constant GL_TEXTURE_COORD_ARRAY_TYPE_EXT =0x8089
public constant GL_TEXTURE_COORD_ARRAY_STRIDE_EXT= 0x808A
public constant GL_TEXTURE_COORD_ARRAY_COUNT_EXT =0x808B
public constant GL_EDGE_FLAG_ARRAY_STRIDE_EXT =0x808C
public constant GL_EDGE_FLAG_ARRAY_COUNT_EXT =0x808D
public constant GL_VERTEX_ARRAY_POINTER_EXT =0x808E
public constant GL_NORMAL_ARRAY_POINTER_EXT =0x808F
public constant GL_COLOR_ARRAY_POINTER_EXT =0x8090
public constant GL_INDEX_ARRAY_POINTER_EXT =0x8091
public constant GL_TEXTURE_COORD_ARRAY_POINTER_EXT =0x8092
public constant GL_EDGE_FLAG_ARRAY_POINTER_EXT =0x8093
public constant GL_DOUBLE_EXT =GL_DOUBLE

public constant GL_BGR_EXT =0x80E0
public constant GL_BGRA_EXT =0x80E1

public constant GL_COLOR_TABLE_FORMAT_EXT =0x80D8
public constant GL_COLOR_TABLE_WIDTH_EXT =0x80D9
public constant GL_COLOR_TABLE_RED_SIZE_EXT =0x80DA
public constant GL_COLOR_TABLE_GREEN_SIZE_EXT =0x80DB
public constant GL_COLOR_TABLE_BLUE_SIZE_EXT =0x80DC
public constant GL_COLOR_TABLE_ALPHA_SIZE_EXT =0x80DD
public constant GL_COLOR_TABLE_LUMINANCE_SIZE_EXT =0x80DE
public constant GL_COLOR_TABLE_INTENSITY_SIZE_EXT =0x80DF

public constant GL_COLOR_INDEX1_EXT =0x80E2
public constant GL_COLOR_INDEX2_EXT =0x80E3
public constant GL_COLOR_INDEX4_EXT =0x80E4
public constant GL_COLOR_INDEX8_EXT =0x80E5
public constant GL_COLOR_INDEX12_EXT =0x80E6
public constant GL_COLOR_INDEX16_EXT =0x80E7

public constant GL_MAX_ELEMENTS_VERTICES_WIN =0x80E8
public constant GL_MAX_ELEMENTS_INDICES_WIN =0x80E9

public constant GL_PHONG_WIN =0x80EA
public constant GL_PHONG_HINT_WIN =0x80EB

public constant GL_FOG_SPECULAR_TEXTURE_WIN =0x80EC

--Functions
public constant xglAccum = define_c_proc(gl,"+glAccum",{GLenum,GLfloat})

public procedure glAccum(atom op,atom val)
	c_proc(xglAccum,{op,val})
end procedure

public constant xglAlphaFunc = define_c_proc(gl,"+glAlphaFunc",{GLenum,GLclampf})

public procedure glAlphaFunc(atom func,atom ref)
	c_proc(xglAlphaFunc,{func,ref})
end procedure

public constant xglAreTexturesResident = define_c_func(gl,"+glAreTexturesResident",{GLsizei,C_POINTER,C_POINTER},GLboolean)

public function glAreTexturesResident(atom n,sequence textures)

	atom residences = allocate_data(sizeof(GLboolean) * n)
	
	c_func(xglAreTexturesResident,{n,textures,residences})
	
	sequence results = {}
	
	for i = 1 to n do
		if peek_pointer(residences + (i - 1) * sizeof(GLboolean)) = GL_TRUE then
			results &= 1
		else
			results &= 0
		end if
	end for
	
	free(residences)
	
	return results
end function

public constant xglArrayElement = define_c_proc(gl,"+glArrayElement",{GLint})

public procedure glArrayElement(atom i)
	c_proc(xglArrayElement,{i})
end procedure

public constant xglBegin = define_c_proc(gl,"+glBegin",{GLenum})

public procedure glBegin(atom mode)
	c_proc(xglBegin,{mode})
end procedure

public constant xglBindTexture = define_c_proc(gl,"+glBindTexture",{GLenum,GLuint})

public procedure glBindTexture(atom target,atom texture)
	c_proc(xglBindTexture,{target,texture})
end procedure

public constant xglBitmap = define_c_proc(gl,"+glBitmap",{GLsizei,GLsizei,GLfloat,GLfloat,GLfloat,GLfloat,C_POINTER})

public procedure glBitmap(atom width,atom height,atom xorig,atom yorig,atom xmove,atom ymove,sequence bitmap)
	atom bitmap_ptr = allocate_data(sizeof(GLubyte) * length(bitmap))
	
	for i = 1 to length(bitmap) do
		poke_pointer(bitmap_ptr + (i - 1) * sizeof(GLubyte), bitmap[i])
	end for
	
	c_proc(xglBitmap,{width,height,xorig,yorig,xmove,ymove,bitmap_ptr})
	
	free(bitmap_ptr)
end procedure

public constant xglBlendFunc = define_c_proc(gl,"+glBlendFunc",{GLenum,GLenum})

public procedure glBlendFunc(atom sfactor,atom dfactor)
	c_proc(xglBlendFunc,{sfactor,dfactor})
end procedure

public constant xglCallList = define_c_proc(gl,"+glCallList",{GLuint})

public procedure glCallList(atom xlist)
	c_proc(xglCallList,{xlist})
end procedure

public constant xglCallLists = define_c_proc(gl,"+glCallLists",{GLsizei,GLenum,C_POINTER})

public procedure glCallLists(atom n,atom xtype,sequence lists)
	atom list_ptr = allocate_data(sizeof(GLubyte) * length(lists))
	
	for i = 1 to length(lists) do
		poke_pointer(list_ptr + (i - 1) * sizeof(GLubyte), lists[i])
	end for
	
	c_proc(xglCallLists,{n,xtype,list_ptr})
	
	free(list_ptr)
end procedure

public constant xglClear = define_c_proc(gl,"+glClear",{GLbitfield})

public procedure glClear(atom mask)
	c_proc(xglClear,{mask})
end procedure

public constant xglClearAccum = define_c_proc(gl,"+glClearAccum",{GLfloat,GLfloat,GLfloat,GLfloat})

public procedure glClearAccum(atom red,atom green,atom blue,atom alpha)
	c_proc(xglClearAccum,{red,green,blue,alpha})
end procedure

public constant xglClearColor = define_c_proc(gl,"+glClearColor",{GLclampf,GLclampf,GLclampf,GLclampf})

public procedure glClearColor(atom red,atom green,atom blue,atom alpha)
	c_proc(xglClearColor,{red,green,blue,alpha})
end procedure

public constant xglClearDepth = define_c_proc(gl,"+glClearDepth",{GLclampd})

public procedure glClearDepth(atom depth)
	c_proc(xglClearDepth,{depth})
end procedure

public constant xglClearIndex = define_c_proc(gl,"+glClearIndex",{GLfloat})

public procedure glClearIndex(atom c)
	c_proc(xglClearIndex,{c})
end procedure

public constant xglClearStencil = define_c_proc(gl,"+glClearStencil",{GLint})

public procedure glClearStencil(atom s)
	c_proc(xglClearStencil,{s})
end procedure

public constant xglClipPlane = define_c_proc(gl,"+glClipPlane",{GLenum,C_POINTER})

public procedure glClipPlane(atom plane,sequence equation)

	if length(equation) != 4 then
		puts(1,"Equation must have 4 elements!\n")
		abort(1)
	end if
	
	atom equation_ptr = allocate_data(sizeof(GLdouble) * 4)
	
	for i = 1 to 4 do
		poke_pointer(equation_ptr + (i - 1) * sizeof(GLdouble), equation[i])
	end for
	
	c_proc(xglClipPlane,{plane,equation_ptr})
	
	free(equation_ptr)
end procedure

public constant xglColor3b = define_c_proc(gl,"+glColor3b",{GLbyte,GLbyte,GLbyte})

public procedure glColor3b(atom red,atom green,atom blue)
	c_proc(xglColor3b,{red,green,blue})
end procedure

public constant xglColor3bv = define_c_proc(gl,"+glColor3bv",{C_POINTER})

public procedure glColor3bv(atom v)
	if length(v) != 3 then
		puts(1,"Color must have 3 elements!\n")
		abort(0)
	end if
	
	atom v_ptr = allocate_data(sizeof(GLbyte) * 3)
	
	for i = 1 to 3 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLbyte), v[i])
	end for
	
	c_proc(xglColor3bv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor3d = define_c_proc(gl,"+glColor3d",{GLdouble,GLdouble,GLdouble})

public procedure glColor3d(atom red,atom green,atom blue)
	c_proc(xglColor3d,{red,green,blue})
end procedure

public constant xglColor3dv = define_c_proc(gl,"+glColor3dv",{C_POINTER})

public procedure glColor3dv(atom v)
	atom v_ptr = allocate_data(sizeof(GLdouble) * 3)
	
	for i = 1 to 3 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLdouble), v[i])
	end for
	
	c_proc(xglColor3dv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor3f = define_c_proc(gl,"+glColor3f",{GLfloat,GLfloat,GLfloat})

public procedure glColor3f(atom red,atom green,atom blue)
	c_proc(xglColor3f,{red,green,blue})
end procedure

public constant xglColor3fv = define_c_proc(gl,"+glColor3fv",{C_POINTER})

public procedure glColor3fv(atom v)
	atom v_ptr = allocate_data(sizeof(GLfloat) * 3)
	
	for i = 1 to 3 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLfloat), v[i])
	end for
	
	c_proc(xglColor3fv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor3i = define_c_proc(gl,"+glColor3i",{GLint,GLint,GLint})

public procedure glColor3i(atom red,atom green,atom blue)
	c_proc(xglColor3i,{red,green,blue})
end procedure

public constant xglColor3iv = define_c_proc(gl,"+glColor3iv",{C_POINTER})

public procedure glColor3iv(atom v)
	atom v_ptr = allocate_data(sizeof(GLint) * 3)
	
	for i = 1 to 3 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLint), v[i])
	end for
	
	c_proc(xglColor3iv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor3s = define_c_proc(gl,"+glColor3s",{GLshort,GLshort,GLshort})

public procedure glColor3s(atom red,atom green,atom blue)
	c_proc(xglColor3s,{red,green,blue})
end procedure

public constant xglColor3sv = define_c_proc(gl,"+glColor3sv",{C_POINTER})

public procedure glColor3sv(atom v)
	atom v_ptr = allocate_data(sizeof(GLshort) * 3)
	
	for i = 1 to 3 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLshort), v[i])
	end for
	
	c_proc(xglColor3sv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor3ub = define_c_proc(gl,"+glColor3ub",{GLubyte,GLubyte,GLubyte})

public procedure glColor3ub(atom red,atom green,atom blue)
	c_proc(xglColor3ub,{red,green,blue})
end procedure

public constant xglColor3ubv = define_c_proc(gl,"+glColor3ubv",{C_POINTER})

public procedure glColor3ubv(atom v)
	atom v_ptr = allocate_data(sizeof(GLubyte) * 3)
	
	for i = 1 to 3 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLubyte), v[i])
	end for
	
	c_proc(xglColor3ubv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor3ui = define_c_proc(gl,"+glColor3ui",{GLuint,GLuint,GLuint})

public procedure glColor3ui(atom red,atom green,atom blue)
	c_proc(xglColor3ui,{red,green,blue})
end procedure

public constant xglColor3uiv = define_c_proc(gl,"+glColor3uiv",{C_POINTER})

public procedure glColor3uiv(atom v)
	atom v_ptr = allocate_data(sizeof(GLuint) * 3)
	
	for i = 1 to 3 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLuint), v[i])
	end for
	
	c_proc(xglColor3uiv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor3us = define_c_proc(gl,"+glColor3us",{GLushort,GLushort,GLushort})

public procedure glColor3us(atom red,atom green,atom blue)
	c_proc(xglColor3us,{red,green,blue})
end procedure

public constant xglColor3usv = define_c_proc(gl,"+glColor3usv",{C_POINTER})

public procedure glColor3usv(atom v)
	atom v_ptr = allocate_data(sizeof(GLushort) * 3)
	
	for i = 1 to 3 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLushort), v[i])
	end for
	
	c_proc(xglColor3usv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor4b = define_c_proc(gl,"+glColor4b",{GLbyte,GLbyte,GLbyte,GLbyte})

public procedure glColor4b(atom red,atom green,atom blue,atom alpha)
	c_proc(xglColor4b,{red,green,blue,alpha})
end procedure

public constant xglColor4bv = define_c_proc(gl,"+glColor4bv",{C_POINTER})

public procedure glColor4bv(atom v)
	atom v_ptr = allocate_data(sizeof(GLbyte) * 4)
	
	for i = 1 to 4 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLbyte), v[i])
	end for
	
	c_proc(xglColor4bv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor4d = define_c_proc(gl,"+glColor4d",{GLdouble,GLdouble,GLdouble,GLdouble})

public procedure glColor4d(atom red,atom green,atom blue,atom alpha)
	c_proc(xglColor4d,{red,green,blue,alpha})
end procedure

public constant xglColor4dv = define_c_proc(gl,"+glColor4dv",{C_POINTER})

public procedure glColor4dv(atom v)
	atom v_ptr = allocate_data(sizeof(GLdouble) * 4)
	
	for i = 1 to 4 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLdouble), v[i])
	end for
	
	c_proc(xglColor4dv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor4f = define_c_proc(gl,"+glColor4f",{GLfloat,GLfloat,GLfloat,GLfloat})

public procedure glColor4f(atom red,atom green,atom blue,atom alpha)
	c_proc(xglColor4f,{red,green,blue,alpha})
end procedure

public constant xglColor4fv = define_c_proc(gl,"+glColor4fv",{C_POINTER})

public procedure glColor4fv(atom v)
	atom v_ptr = allocate_data(sizeof(GLfloat) * 4)
	
	for i = 1 to 4 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLfloat), v[i])
	end for
	
	c_proc(xglColor4fv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor4i = define_c_proc(gl,"+glColor4i",{GLint,GLint,GLint,GLint})

public procedure glColor4i(atom red,atom green,atom blue,atom alpha)
	c_proc(xglColor4i,{red,green,blue,alpha})
end procedure

public constant xglColor4iv = define_c_proc(gl,"+glColor4iv",{C_POINTER})

public procedure glColor4iv(atom v)
	atom v_ptr = allocate_data(sizeof(GLint) * 4)
	
	for i = 1 to 4 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLint), v[i])
	end for
	
	c_proc(xglColor4iv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor4s = define_c_proc(gl,"+glColor4s",{GLshort,GLshort,GLshort,GLshort})

public procedure glColor4s(atom red,atom green,atom blue,atom alpha)
	c_proc(xglColor4s,{red,green,blue,alpha})
end procedure

public constant xglColor4sv = define_c_proc(gl,"+glColor4sv",{C_POINTER})

public procedure glColor4sv(atom v)
	atom v_ptr = allocate_data(sizeof(GLshort) * 4)
	
	for i = 1 to 4 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLshort), v[i])
	end for
	
	c_proc(xglColor4sv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor4ub = define_c_proc(gl,"+glColor4ub",{GLubyte,GLubyte,GLubyte,GLubyte})

public procedure glColor4ub(atom red,atom green,atom blue,atom alpha)
	c_proc(xglColor4ub,{red,green,blue,alpha})
end procedure

public constant xglColor4ubv = define_c_proc(gl,"+glColor4ubv",{C_POINTER})

public procedure glColor4ubv(atom v)
	atom v_ptr = allocate_data(sizeof(GLubyte * 4))
	
	for i = 1 to 4 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLubyte),v[i])
	end for
	
	c_proc(xglColor4ubv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor4ui = define_c_proc(gl,"+glColor4ui",{GLuint,GLuint,GLuint,GLuint})

public procedure glColor4ui(atom red,atom green,atom blue,atom alpha)
	c_proc(xglColor4ui,{red,green,blue,alpha})
end procedure

public constant xglColor4uiv = define_c_proc(gl,"+glColor4uiv",{C_POINTER})

public procedure glColor4uiv(atom v)
	atom v_ptr = allocate_data(sizeof(GLuint) * 4)
	
	for i = 1 to 4 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLuint), v[i])
	end for
		
	c_proc(xglColor4uiv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColor4us = define_c_proc(gl,"+glColor4us",{GLushort,GLushort,GLushort,GLushort})

public procedure glColor4us(atom red,atom green,atom blue,atom alpha)
	c_proc(xglColor4us,{red,green,blue,alpha})
end procedure

public constant xglColor4usv = define_c_proc(gl,"+glColor4usv",{C_POINTER})

public procedure glColor4usv(atom v)
	atom v_ptr = allocate_data(sizeof(GLushort) * 4)
	
	for i = 1 to 4 do
		poke_pointer(v_ptr + (i - 1) * sizeof(GLushort), v[i])
	end for
	
	c_proc(xglColor4usv,{v_ptr})
	
	free(v_ptr)
end procedure

public constant xglColorMask = define_c_proc(gl,"+glColorMask",{GLboolean,GLboolean,GLboolean,GLboolean})

public procedure glColorMask(atom red,atom green,atom blue,atom alpha)
	c_proc(xglColorMask,{red,green,blue,alpha})
end procedure

public constant xglColorMaterial = define_c_proc(gl,"+glColorMaterial",{GLenum,GLenum})

public procedure glColorMaterial(atom face,atom mode)
	c_proc(xglColorMaterial,{face,mode})
end procedure

public constant xglColorPointer = define_c_proc(gl,"+glColorPointer",{GLint,GLenum,GLsizei,C_POINTER})

public procedure glColorPointer(atom size,atom xtype,atom stride,atom ptr)
	atom p_ptr = allocate_data(sizeof(GLbyte) * length(ptr))
	
	for i = 1 to length(ptr) do
		poke_pointer(p_ptr + (i - 1) * sizeof(GLbyte), ptr[i])
	end for
	
	c_proc(xglColorPointer,{size,xtype,stride,p_ptr})
	
	free(p_ptr)
end procedure

public constant xglCopyPixels = define_c_proc(gl,"+glCopyPixels",{GLint,GLint,GLsizei,GLsizei,GLenum})

public procedure glCopyPixels(atom x,atom y,atom width,atom height,atom xtype)
	c_proc(xglCopyPixels,{x,y,width,height,xtype})
end procedure

public constant xglCopyTexImage1D = define_c_proc(gl,"+glCopyTexImage1D",{GLenum,GLint,GLenum,GLint,GLint,GLsizei,GLint})

public procedure glCopyTexImage1D(atom target,atom level,atom internalFormat,atom x,atom y,atom width,atom border)
	c_proc(xglCopyTexImage1D,{target,level,internalFormat,x,y,width,border})
end procedure

public constant xglCopyTexImage2D = define_c_proc(gl,"+glCopyTexImage2D",{GLenum,GLint,GLenum,GLint,GLint,GLsizei,GLsizei,GLint})

public procedure glCopyTexImage2D(atom target,atom level,atom internalFormat,atom x,atom y,atom width,atom height,atom border)
	c_proc(xglCopyTexImage2D,{target,level,internalFormat,x,y,width,height,border})
end procedure

public constant xglCopyTexSubImage1D = define_c_proc(gl,"+glCopyTexSubImage1D",{GLenum,GLint,GLint,GLint,GLint,GLsizei})

public procedure glCopyTexSubImage1D(atom target,atom level,atom xoffset,atom x,atom y,atom width)
	c_proc(xglCopyTexSubImage1D,{target,level,xoffset,x,y,width})
end procedure

public constant xglCopyTexSubImage2D = define_c_proc(gl,"+glCopyTexSubImage2D",{GLenum,GLint,GLint,GLint,GLint,GLint,GLsizei,GLsizei})

public procedure glCopyTexSubImage2D(atom target,atom level,atom xoffset,atom yoffset,atom x,atom y,atom width,atom height)
	c_proc(xglCopyTexSubImage2D,{target,level,xoffset,yoffset,x,y,width,height})
end procedure

public constant xglCullFace = define_c_proc(gl,"+glCullFace",{GLenum})

public procedure glCullFace(atom mode)
	c_proc(xglCullFace,{mode})
end procedure

public constant xglDeleteLists = define_c_proc(gl,"+glDeleteLists",{GLuint,GLsizei})

public procedure glDeleteLists(atom _list,atom _range)
	c_proc(xglDeleteLists,{_list,_range})
end procedure

public constant xglDeleteTextures = define_c_proc(gl,"+glDeleteTextures",{GLsizei,C_POINTER})

public procedure glDeleteTextures(atom n,sequence textures)
	atom texture_ptr = allocate_data(sizeof(GLuint) * n)
	
	for i = 1 to n do
		poke_pointer(texture_ptr + (i - 1) * sizeof(GLuint), textures[i])
	end for
	
	c_proc(xglDeleteTextures,{n,textures})
	
	free(texture_ptr)
end procedure

public constant xglDepthFunc = define_c_proc(gl,"+glDepthFunc",{GLenum})

public procedure glDepthFunc(atom func)
	c_proc(xglDepthFunc,{func})
end procedure

public constant xglDepthMask = define_c_proc(gl,"+glDepthMask",{GLboolean})

public procedure glDepthMask(atom flag)
	c_proc(xglDepthMask,{flag})
end procedure

public constant xglDepthRange = define_c_proc(gl,"+glDepthRange",{GLclampd,GLclampd})

public procedure glDepthRange(atom zNear,atom zFar)
	c_proc(xglDepthRange,{zNear,zFar})
end procedure

public constant xglDisable = define_c_proc(gl,"+glDisable",{GLenum})

public procedure glDisable(atom cap)
	c_proc(xglDisable,{cap})
end procedure

public constant xglDisableClientState = define_c_proc(gl,"+glDisableClientState",{GLenum})

public procedure glDisableClientState(atom array)
	c_proc(xglDisableClientState,{array})
end procedure

public constant xglDrawArrays = define_c_proc(gl,"+glDrawArrays",{GLenum,GLint,GLsizei})

public procedure glDrawArrays(atom mode,atom first,atom count)
	c_proc(xglDrawArrays,{mode,first,count})
end procedure

public constant xglDrawBuffer = define_c_proc(gl,"+glDrawBuffer",{GLenum})

public procedure glDrawBuffer(atom mode)
	c_proc(xglDrawBuffer,{mode})
end procedure

public constant xglDrawElements = define_c_proc(gl,"+glDrawElements",{GLenum,GLsizei,GLenum,C_POINTER})

public procedure glDrawElements(atom mode,atom count,atom xtype,atom indices)
	atom indices_ptr
	
	if xtype = GL_UNSIGNED_BYTE then
		indices_ptr = allocate_data(sizeof(GLbyte) * count)
		elsif xtype = GL_UNSIGNED_SHORT then
			indices_ptr = allocate_data(sizeof(GLshort) * count)
		elsif xtype = GL_UNSIGNED_INT then
			indices_ptr = allocate_data(sizeof(GLint) * count)
	end if
	
	for i = 1 to count do
		poke_pointer(indices_ptr + (i - 1) * sizeof(xtype), indices[i])
	end for
	
	c_proc(xglDrawElements,{mode,count,xtype,indices_ptr})
	
	free(indices_ptr)
end procedure

public constant xglDrawPixels = define_c_proc(gl,"+glDrawPixels",{GLsizei,GLsizei,GLenum,C_POINTER})

public procedure glDrawPixels(atom width,atom height,atom format,atom xtype,sequence pixels)
	atom pixel_size = 0
	
	if format = GL_RGB then
		pixel_size = 3
		elsif format = GL_RGBA then
			pixel_size = 4
		elsif format = GL_LUMINANCE then
			pixel_size = 1
		elsif format = GL_LUMINANCE_ALPHA then
			pixel_size = 2
	end if
	
	if length(pixels) != width * height * pixel_size then
		puts(1,"Wrong pixel data!\n")
	end if
	
	atom pixels_ptr
	if xtype = GL_UNSIGNED_BYTE then
		pixels_ptr = allocate_data(sizeof(GLbyte) * length(pixels))
		elsif xtype = GL_FLOAT then
			pixels_ptr = allocate_data(sizeof(GLfloat) * length(pixels))
	end if
	
	for i = 1 to length(pixels) do
		poke_pointer(pixels_ptr + (i - 1) * sizeof(xtype), pixels[i])
	end for
	
	c_proc(xglDrawPixels,{width,height,format,xtype,pixels_ptr})
	
	free(pixels_ptr)
end procedure

public constant xglEdgeFlag = define_c_proc(gl,"+glEdgeFlag",{GLboolean})

public procedure glEdgeFlag(atom flag)
	c_proc(xglEdgeFlag,{flag})
end procedure

public constant xglEdgeFlagPointer = define_c_proc(gl,"+glEdgeFlagPointer",{GLsizei,C_POINTER})

public procedure glEdgeFlagPointer(atom stride,atom edge_flags)
	atom flags_ptr = allocate_data(sizeof(GLboolean) * length(edge_flags))
	
	for i = 1 to length(edge_flags) do
		poke_pointer(flags_ptr + (i - 1) * sizeof(GLboolean), edge_flags[i])
	end for
	
	c_proc(xglEdgeFlagPointer,{stride,flags_ptr})
	
	free(flags_ptr)
end procedure

public constant xglEdgeFlagv = define_c_proc(gl,"+glEdgeFlagv",{C_POINTER})

public procedure glEdgeFlagv(atom flag)
	c_proc(xglEdgeFlagv,{flag})
end procedure

public constant xglEnable = define_c_proc(gl,"+glEnable",{GLenum})

public procedure glEnable(atom cap)
	c_proc(xglEnable,{cap})
end procedure

public constant xglEnableClientState = define_c_proc(gl,"+glEnableClientState",{GLenum})

public procedure glEnableClientState(atom array)
	c_proc(xglEnableClientState,{array})
end procedure

public constant xglEnd = define_c_proc(gl,"+glEnd",{})

public procedure glEnd()
	c_proc(xglEnd,{})
end procedure

public constant xglMatrixMode = define_c_proc(gl,"+glMatrixMode",{GLenum})

public procedure glMatrixMode(atom mode)
	c_proc(xglMatrixMode,{mode})
end procedure

public constant xglEvalCoord1d = define_c_proc(gl,"+glEvalCoord1d",{GLdouble})

public procedure glEvalCoord1d(atom u)
	c_proc(xglEvalCoord1d,{u})
end procedure

public constant xglEvalCoord1dv = define_c_proc(gl,"+glEvalCoord1dv",{C_POINTER})

public procedure glEvalCoord1dv(atom u)
	c_proc(xglEvalCoord1dv,{u})
end procedure

public constant xglEvalCoord1f = define_c_proc(gl,"+glEvalCoord1f",{GLfloat})

public procedure glEvalCoord1f(atom u)
	c_proc(xglEvalCoord1f,{u})
end procedure

public constant xglEvalCoord1fv = define_c_proc(gl,"+glEvalCoord1fv",{C_POINTER})

public procedure glEvalCoord1fv(atom u)
	c_proc(xglEvalCoord1fv,{u})
end procedure

public constant xglEvalCoord2d = define_c_proc(gl,"+glEvalCoord2d",{GLdouble,GLdouble})

public procedure glEvalCoord2d(atom u,atom v)
	c_proc(xglEvalCoord2d,{u,v})
end procedure

public constant xglEvalCoord2dv = define_c_proc(gl,"+glEvalCoord2dv",{C_POINTER})

public procedure glEvalCoord2dv(atom u)
	c_proc(xglEvalCoord2dv,{u})
end procedure

public constant xglEvalCoord2f = define_c_proc(gl,"+glEvalCoord2f",{GLfloat,GLfloat})

public procedure glEvalCoord2f(atom u,atom v)
	c_proc(xglEvalCoord2f,{u,v})
end procedure

public constant xglEvalCoord2fv = define_c_proc(gl,"+glEvalCoord2fv",{C_POINTER})

public procedure glEvalCoord2fv(atom u)
	c_proc(xglEvalCoord2fv,{u})
end procedure

public constant xglEvalMesh1 = define_c_proc(gl,"+glEvalMesh1",{GLenum,GLint,GLint})

public procedure glEvalMesh1(atom mode,atom i1,atom i2)
	c_proc(xglEvalMesh1,{mode,i1,i2})
end procedure

public constant xglEvalMesh2 = define_c_proc(gl,"+glEvalMesh2",{GLenum,GLint,GLint,GLint,GLint})

public procedure glEvalMesh2(atom mode,atom i1,atom i2,atom j1,atom j2)
	c_proc(xglEvalMesh2,{mode,i1,i2,j1,j2})
end procedure

public constant xglEvalPoint1 = define_c_proc(gl,"+glEvalPoint1",{GLint})

public procedure glEvalPoint1(atom i)
	c_proc(xglEvalPoint1,{i})
end procedure

public constant xglEvalPoint2 = define_c_proc(gl,"+glEvalPoint2",{GLint,GLint})

public procedure glEvalPoint2(atom i,atom j)
	c_proc(xglEvalPoint2,{i,j})
end procedure

public constant xglFeedbackBuffer = define_c_proc(gl,"+glFeedbackBuffer",{GLsizei,GLenum,C_POINTER})

public procedure glFeedbackBuffer(atom size,atom xtype,object buffer)

	atom num_values_per_entry
	
	if xtype = GL_2D then
		num_values_per_entry = 2
		elsif xtype = GL_3D then
			num_values_per_entry = 3
			--elsif xtype = GL_4D then
			--	num_values_per_entry = 4
	end if
	
	if length(buffer) != size * num_values_per_entry then
		puts(1,"Buffer size does not match!\n")
	end if
	
	atom buffer_ptr = allocate_data(sizeof(GLfloat) * length(buffer))
	
	for i = 1 to length(buffer) do
		poke_pointer(buffer_ptr + (i - 1) * sizeof(GLfloat), buffer[i])
	end for
	
	c_proc(xglFeedbackBuffer,{size,xtype,buffer_ptr})
	
	free(buffer_ptr)
end procedure

public constant xglFinish = define_c_proc(gl,"+glFinish",{})

public procedure glFinish()
	c_proc(xglFinish,{})
end procedure

public constant xglFlush = define_c_proc(gl,"+glFlush",{})

public procedure glFlush()
	c_proc(xglFlush,{})
end procedure

public constant xglFogf = define_c_proc(gl,"+glFogf",{GLenum,GLfloat})

public procedure glFogf(atom pname,atom param)
	c_proc(xglFogf,{pname,param})
end procedure

public constant xlFogfv = define_c_proc(gl,"+lFogfv",{GLenum,C_POINTER})

public procedure lFogfv(atom pname,atom params)

	atom num_values
	
	if pname = GL_FOG_COLOR then
		num_values = 4
		else
		num_values = 1
	end if
	
	atom params_ptr = allocate_data(sizeof(GLfloat) * num_values)
	
	for i = 1 to num_values do
		poke_pointer(params_ptr + (i - 1) * sizeof(GLfloat), params[i])
	end for
	
	c_proc(xlFogfv,{pname,params_ptr})
	
	free(params_ptr)
end procedure

public constant xglFogi = define_c_proc(gl,"+glFogi",{GLenum,GLint})

public procedure glFogi(atom pname,atom param)
	c_proc(xglFogi,{pname,param})
end procedure

public constant xglFogiv = define_c_proc(gl,"+glFogiv",{GLenum,C_POINTER})

public procedure glFogiv(atom pname,atom params)
	atom num_values
	if pname = GL_FOG_COLOR then
		num_values = 4
		else
			num_values = 1
	end if
	
	atom params_ptr = allocate_data(sizeof(GLint) * num_values)
	
	for i = 1 to num_values do
		poke_pointer(params_ptr + (i - 1) * sizeof(GLint), params[i])
	end for
	
	c_proc(xglFogiv,{pname,params_ptr})
	
	free(params_ptr)
end procedure

public constant xglFrontFace = define_c_proc(gl,"+glFrontFace",{GLenum})

public procedure glFrontFace(atom mode)
	c_proc(xglFrontFace,{mode})
end procedure

public constant xglFrustum = define_c_proc(gl,"+glFrustum",{GLdouble,GLdouble,GLdouble,GLdouble,GLdouble,GLdouble})

public procedure glFrustum(atom left,atom right,atom bottom,atom top,atom zNear,atom zFar)
	c_proc(xglFrustum,{left,right,bottom,top,zNear,zFar})
end procedure

public constant xglGenLists = define_c_func(gl,"+glGenLists",{GLsizei},GLuint)

public function glGenLists(atom _range)
	return c_func(xglGenLists,{_range})
end function

public constant xglGenTextures = define_c_proc(gl,"+glGenTextures",{GLsizei,C_POINTER})

public procedure glGenTextures(atom n,sequence textures)
	if length(textures) < n then
		textures = repeat(0,n)
	end if
	
	atom textures_ptr = allocate_data(sizeof(GLuint) * n)
	
	for i = 1 to n do
		poke_pointer(textures_ptr + (i - 1) * sizeof(GLuint), textures[i])
	end for
	
	c_proc(xglGenTextures,{n,textures_ptr})
	
	for i = 1 to n do
		textures[i] = peek_pointer(textures_ptr + (i - 1) * sizeof(GLuint))
	end for
	
	free(textures_ptr)
end procedure

public constant xglGetBooleanv = define_c_proc(gl,"+glGetBooleanv",{GLenum,C_POINTER})

public procedure glGetBooleanv(atom pname,atom params)
	atom params_ptr = allocate_data(sizeof(GLboolean))
	
	c_proc(xglGetBooleanv,{pname,params_ptr})
	
	params = peek_pointer(params_ptr)
	
	free(params_ptr)
end procedure

public constant xglGetClipPlane = define_c_proc(gl,"+glGetClipPlane",{GLenum,C_POINTER})

public procedure glGetClipPlane(atom plane,sequence equation)
	if length(equation) < 4 then
		equation = repeat(0.0,4)
	end if
	
	atom equation_ptr = allocate_data(sizeof(GLdouble) * 4)
	
	for i = 1 to 4 do
		equation[i] = peek_pointer(equation_ptr + (i - 1) * sizeof(GLdouble))
	end for
	
	c_proc(xglGetClipPlane,{plane,equation_ptr})
	
	free(equation_ptr)
end procedure

public constant xglGetDoublev = define_c_proc(gl,"+glGetDoublev",{GLenum,C_POINTER})

public procedure glGetDoublev(atom pname,sequence params)
	atom num_values
	
	if pname = GL_MODELVIEW_MATRIX or pname = GL_PROJECTION_MATRIX or pname = GL_TEXTURE_MATRIX then
		num_values = 16
		else
		num_values = 1
	end if
	
	if length(params) < num_values then
		params = repeat(0.0,num_values)
	end if
	
	atom params_ptr = allocate_data(sizeof(GLdouble) * num_values)
	
	for i = 1 to num_values do
		params[i] = peek_pointer(params_ptr + (i - 1) * sizeof(GLdouble))
	end for
	
	c_proc(xglGetDoublev,{pname,params_ptr})
	
	free(params_ptr)
end procedure

public constant xglGetError = define_c_func(gl,"+glGetError",{},GLenum)

public function glGetError()
	return c_func(xglGetError,{})
end function

public constant xglGetFloatv = define_c_proc(gl,"+glGetFloatv",{GLenum,C_POINTER})

public procedure glGetFloatv(atom pname,sequence params)
	atom num_values
	
	if pname = GL_MODELVIEW_MATRIX or pname = GL_PROJECTION_MATRIX or pname = GL_TEXTURE_MATRIX then
		num_values = 16
		else
		num_values = 1
	end if
	
	if length(params) < num_values then
		params = repeat(0.0,num_values)
	end if
	
	atom params_ptr = allocate_data(sizeof(GLfloat) * num_values)
	
	for i = 1 to num_values do
		params[i] = peek_pointer(params_ptr + (i - 1) * sizeof(GLfloat))
	end for
	
	c_proc(xglGetFloatv,{pname,params_ptr})
	
	free(params_ptr)
end procedure

public constant xglGetIntegerv = define_c_proc(gl,"+glGetIntegerv",{GLenum,C_POINTER})

public procedure glGetIntegerv(atom pname,sequence params)
	atom num_values
	
	if pname = GL_VIEWPORT or pname = GL_SCISSOR_BOX then
		num_values = 4
		else
		num_values = 1
	end if
	
	if length(params) < num_values then
		params = repeat(0,num_values)
	end if
	
	atom params_ptr = allocate_data(sizeof(GLint) * num_values)
	
	for i = 1 to num_values do
		params[i] = peek_pointer(params_ptr + (i - 1) * sizeof(GLint))
	end for
	
	c_proc(xglGetIntegerv,{pname,params_ptr})
	
	free(params_ptr)
end procedure

public constant xglGetLightfv = define_c_proc(gl,"+glGetLightfv",{GLenum,GLenum,C_POINTER})

public procedure glGetLightfv(atom light,atom pname,sequence params)
	atom num_values
	
	if pname = GL_POSITION or pname = GL_AMBIENT or pname = GL_DIFFUSE or pname=  GL_SPECULAR then
		num_values = 4
		else
		num_values = 1
	end if
	
	if length(params) < num_values then
		params = repeat(0.0,num_values)
	end if
	
	atom params_ptr = allocate_data(sizeof(GLfloat) * num_values)
	
	for i = 1 to num_values do
		params[i] = peek_pointer(params_ptr + (i - 1) * sizeof(GLfloat))
	end for
	
	c_proc(xglGetLightfv,{light,pname,params_ptr})
	
	free(params_ptr)
end procedure

public constant xglGetLightiv = define_c_proc(gl,"+glGetLightiv",{GLenum,GLenum,C_POINTER})

public procedure glGetLightiv(atom light,atom pname,sequence params)
	atom num_values
	
	if pname = GL_POSITION or pname = GL_AMBIENT or pname = GL_DIFFUSE or pname = GL_SPECULAR then
		num_values = 4
		else
		num_values = 1
	end if
	
	if length(params) < num_values then
		params = repeat(0,num_values)
	end if
	
	atom params_ptr = allocate_data(sizeof(GLint) * num_values)
	
	for i = 1 to num_values do
		params[i] = peek_pointer(params_ptr + (i - 1) * sizeof(GLint))
	end for
	
	c_proc(xglGetLightiv,{light,pname,params_ptr})
	
	free(params_ptr)
end procedure

public constant xglGetMapdv = define_c_proc(gl,"+glGetMapdv",{GLenum,GLenum,C_POINTER})

public procedure glGetMapdv(atom target,atom query,sequence v)
	atom num_values
	num_values = 2
	
	if length(v) < num_values then
		v = repeat(0.0,num_values)
	end if
	
	atom v_ptr = allocate_data(sizeof(GLdouble) * num_values)
	
	for i = 1 to num_values do
		v[i] = peek_pointer(v_ptr + (i - 1) * sizeof(GLdouble))
	end for
	
	c_proc(xglGetMapdv,{target,query,v_ptr})
	
	free(v_ptr)
end procedure

public constant xglGetMapfv = define_c_proc(gl,"+glGetMapfv",{GLenum,GLenum,C_POINTER})

public procedure glGetMapfv(atom target,atom query,sequence v)
	c_proc(xglGetMapfv,{target,query,v})
end procedure

public constant xglGetMapiv = define_c_proc(gl,"+glGetMapiv",{GLenum,GLenum,C_POINTER})

public procedure glGetMapiv(atom target,atom query,sequence v)
	c_proc(xglGetMapiv,{target,query,v})
end procedure

public constant xglGetMaterialfv = define_c_proc(gl,"+glGetMaterialfv",{GLenum,GLenum,C_POINTER})

public procedure glGetMaterialfv(atom face,atom pname,sequence params)
	c_proc(xglGetMaterialfv,{face,pname,params})
end procedure

public constant xglGetMaterialiv = define_c_proc(gl,"+glGetMaterialiv",{GLenum,GLenum,C_POINTER})

public procedure glGetMaterialiv(atom face,atom pname,sequence params)
	c_proc(xglGetMaterialiv,{face,pname,params})
end procedure

public constant xglGetPixelMapfv = define_c_proc(gl,"+glGetPixelMapfv",{GLenum,C_POINTER})

public procedure glGetPixelMapfv(atom _map,atom values)
	c_proc(xglGetPixelMapfv,{_map,values})
end procedure

public constant xglGetPixelMapuiv = define_c_proc(gl,"+glGetPixelMapuiv",{GLenum,C_POINTER})

public procedure glGetPixelMapuiv(atom _map,atom values)
	c_proc(xglGetPixelMapuiv,{_map,values})
end procedure

public constant xglGetPixelMapusv = define_c_proc(gl,"+glGetPixelMapusv",{GLenum,C_POINTER})

public procedure glGetPixelMapusv(atom _map,atom values)
	c_proc(xglGetPixelMapusv,{_map,values})
end procedure

public constant xglGetPointerv = define_c_proc(gl,"+glGetPointerv",{GLenum,C_POINTER})

public procedure glGetPointerv(atom pname,object params)
	c_proc(xglGetPointerv,{pname,params})
end procedure

public constant xglGetPolygonStipple = define_c_proc(gl,"+glGetPolygonStipple",{C_POINTER})

public procedure glGetPolygonStipple(atom mask)
	c_proc(xglGetPolygonStipple,{mask})
end procedure

public constant xglGetString = define_c_func(gl,"+glGetString",{GLenum},C_POINTER)

public function glGetString(object name)
	return c_func(xglGetString,{name})
end function

public constant xglGetTexEnvfv = define_c_proc(gl,"+glGetTexEnvfv",{GLenum,GLenum,C_POINTER})

public procedure glGetTexEnvfv(atom target,atom pname,sequence params)
	c_proc(xglGetTexEnvfv,{target,pname,params})
end procedure

public constant xglGetTexEnviv = define_c_proc(gl,"+glGetTexEnviv",{GLenum,GLenum,C_POINTER})

public procedure glGetTexEnviv(atom target,atom pname,sequence params)
	c_proc(xglGetTexEnviv,{target,pname,params})
end procedure

public constant xglGetTexGendv = define_c_proc(gl,"+glGetTexGendv",{GLenum,GLenum,C_POINTER})

public procedure glGetTexGendv(atom coord,atom pname,sequence params)
	c_proc(xglGetTexGendv,{coord,pname,params})
end procedure

public constant xglGetTexGenfv = define_c_proc(gl,"+glGetTexGenfv",{GLenum,GLenum,C_POINTER})

public procedure glGetTexGenfv(atom coord,atom pname,sequence params)
	c_proc(xglGetTexGenfv,{coord,pname,params})
end procedure

public constant xglGetTexGeniv = define_c_proc(gl,"+glGetTexGeniv",{GLenum,GLenum,C_POINTER})

public procedure glGetTexGeniv(atom coord,atom pname,sequence params)
	c_proc(xglGetTexGeniv,{coord,pname,params})
end procedure

public constant xglGetTexImage = define_c_proc(gl,"+glGetTexImage",{GLenum,GLint,GLenum,GLenum,C_POINTER})

public procedure glGetTexImage(atom target,atom level,atom format,atom xtype,sequence pixels)
	c_proc(xglGetTexImage,{target,level,format,xtype,pixels})
end procedure

public constant xglGetTexLevelParameterfv = define_c_proc(gl,"+glGetTexLevelParameterfv",{GLenum,GLint,GLenum,C_POINTER})

public procedure glGetTexLevelParameterfv(atom target,atom level,atom pname,sequence params)
	c_proc(xglGetTexLevelParameterfv,{target,level,pname,params})
end procedure

public constant xglGetTexLevelParameteriv = define_c_proc(gl,"+glGetTexLevelParameteriv",{GLenum,GLint,GLenum,C_POINTER})

public procedure glGetTexLevelParameteriv(atom target,atom level,atom pname,sequence params)
	c_proc(xglGetTexLevelParameteriv,{target,level,pname,params})
end procedure

public constant xglGetTexParameterfv = define_c_proc(gl,"+glGetTexParameterfv",{GLenum,GLenum,C_POINTER})

public procedure glGetTexParameterfv(atom target,atom pname,sequence params)
	c_proc(xglGetTexParameterfv,{target,pname,params})
end procedure

public constant xglGetTexParameteriv = define_c_proc(gl,"+glGetTexParameteriv",{GLenum,GLenum,C_POINTER})

public procedure glGetTexParameteriv(atom target,atom pname,sequence params)
	c_proc(xglGetTexParameteriv,{target,pname,params})
end procedure

public constant xglHint = define_c_proc(gl,"+glHint",{GLenum,GLenum})

public procedure glHint(atom target,atom mode)
	c_proc(xglHint,{target,mode})
end procedure

public constant xglIndexMask = define_c_proc(gl,"+glIndexMask",{GLuint})

public procedure glIndexMask(atom mask)
	c_proc(xglIndexMask,{mask})
end procedure

public constant xglIndexPointer = define_c_proc(gl,"+glIndexPointer",{GLenum,GLsizei,C_POINTER})

public procedure glIndexPointer(atom xtype,atom stride,object ptr)
	c_proc(xglIndexPointer,{xtype,stride,ptr})
end procedure

public constant xglIndexd = define_c_proc(gl,"+glIndexd",{GLdouble})

public procedure glIndexd(atom c)
	c_proc(xglIndexd,{c})
end procedure

public constant xglIndexdv = define_c_proc(gl,"+glIndexdv",{C_POINTER})

public procedure glIndexdv(atom c)
	c_proc(xglIndexdv,{c})
end procedure

public constant xglIndexf = define_c_proc(gl,"+glIndexf",{GLfloat})

public procedure glIndexf(atom c)
	c_proc(xglIndexf,{c})
end procedure

public constant xglIndexfv = define_c_proc(gl,"+glIndexfv",{C_POINTER})

public procedure glIndexfv(atom c)
	c_proc(xglIndexfv,{c})
end procedure

public constant xglIndexi = define_c_proc(gl,"+glIndexi",{GLint})

public procedure glIndexi(atom c)
	c_proc(xglIndexi,{c})	
end procedure

public constant xglIndexiv = define_c_proc(gl,"+glIndexiv",{C_POINTER})

public procedure glIndexiv(atom c)
	c_proc(xglIndexiv,{c})
end procedure

public constant xglIndexs = define_c_proc(gl,"+glIndexs",{GLshort})

public procedure glIndexs(atom c)
	c_proc(xglIndexs,{c})
end procedure

public constant xglIndexsv = define_c_proc(gl,"+glIndexsv",{C_POINTER})

public procedure glIndexsv(atom c)
	c_proc(xglIndexsv,{c})
end procedure

public constant xglIndexub = define_c_proc(gl,"+glIndexub",{GLubyte})

public procedure glIndexub(atom c)
	c_proc(xglIndexub,{c})
end procedure

public constant xglIndexubv = define_c_proc(gl,"+glIndexubv",{C_POINTER})

public procedure glIndexubv(atom c)
	c_proc(xglIndexubv,{c})
end procedure

public constant xglInitNames = define_c_proc(gl,"+glInitNames",{})

public procedure glInitNames()
	c_proc(xglInitNames,{})
end procedure

public constant xlInterleavedArrays = define_c_proc(gl,"+lInterleavedArrays",{GLenum,GLsizei,C_POINTER})

public procedure lInterleavedArrays(atom format,atom stride,object ptr)
	c_proc(xlInterleavedArrays,{format,stride,ptr})
end procedure

public constant xglIsEnabled = define_c_func(gl,"+glIsEnabled",{GLenum},GLboolean)

public function glIsEnabled(atom cap)
	return c_func(xglIsEnabled,{cap})
end function

public constant xglIsList = define_c_func(gl,"+glIsList",{GLuint},GLboolean)

public function glIsList(atom _list)
	return c_func(xglIsList,{_list})
end function

public constant xglIsTexture = define_c_func(gl,"+glIsTexture",{GLuint},GLboolean)

public function glIsTexture(atom texture)
	return c_func(xglIsTexture,{texture})
end function

public constant xglLightModelf = define_c_proc(gl,"+glLightModelf",{GLenum,GLfloat})

public procedure glLightModelf(atom pname,atom param)
	c_proc(xglLightModelf,{pname,param})
end procedure

public constant xglLightModelfv = define_c_proc(gl,"+glLightModelfv",{GLenum,C_POINTER})

public procedure glLightModelfv(atom pname,sequence params)
	c_proc(xglLightModelfv,{pname,params})
end procedure

public constant xglLightModeli = define_c_proc(gl,"+glLightModeli",{GLenum,GLint})

public procedure glLightModeli(atom pname,atom param)
	c_proc(xglLightModeli,{pname,param})
end procedure

public constant xglLightModeliv = define_c_proc(gl,"+glLightModeliv",{GLenum,C_POINTER})

public procedure glLightModeliv(atom pname,sequence params)
	c_proc(xglLightModeliv,{pname,params})
end procedure

public constant xglLightf = define_c_proc(gl,"+glLightf",{GLenum,GLenum,GLfloat})

public procedure glLightf(atom light,atom pname,atom param)
	c_proc(xglLightf,{light,pname,param})
end procedure

public constant xglLightfv = define_c_proc(gl, "+glLightfv", {GLenum,GLenum, C_POINTER})

public procedure glLightfv(atom light,atom pname,object params)
	integer required = 0
	
	switch pname do
	case GL_AMBIENT, GL_DIFFUSE, GL_SPECULAR,GL_POSITION then
	required = 4
	case GL_SPOT_DIRECTION then
	required = 3
	case GL_SPOT_EXPONENT,GL_SPOT_CUTOFF,GL_CONSTANT_ATTENUATION,GL_LINEAR_ATTENUATION,GL_QUADRATIC_ATTENUATION then
	required = 1
	end switch
	
	if required != length(params) then
		printf(1,"Expected params: %d",{length(params)})
	end if
	
	atom pparams = allocate_data(sizeof(C_INT) * length(params))
	poke4(pparams,params)
	
	c_proc(xglLightiv,{light,pname,pparams})
	
	free(pparams)
end procedure

public constant xglLighti = define_c_proc(gl,"+glLighti",{GLenum,GLenum,GLint})

public procedure glLighti(atom light,atom pname,atom param)
	c_proc(xglLighti,{light,pname,param})
end procedure

public constant xglLightiv = define_c_proc(gl,"+glLightiv",{GLenum,GLenum,C_POINTER})

public procedure glLightiv(atom light,atom pname,sequence params)
	c_proc(xglLightiv,{light,pname,params})
end procedure

public constant xglLineStipple = define_c_proc(gl,"+glLineStipple",{GLint,GLushort})

public procedure glLineStipple(atom factor,atom pattern)
	c_proc(xglLineStipple,{factor,pattern})
end procedure

public constant xglLineWidth = define_c_proc(gl,"+glLineWidth",{GLfloat})

public procedure glLineWidth(atom width)
	c_proc(xglLineWidth,{width})
end procedure

public constant xglListBase = define_c_proc(gl,"+glListBase",{GLuint})

public procedure glListBase(atom base)
	c_proc(xglListBase,{base})
end procedure

public constant xglLoadIdentity = define_c_proc(gl,"+glLoadIdentity",{})

public procedure glLoadIdentity()
	c_proc(xglLoadIdentity,{})
end procedure

public constant xglLoadMatrixd = define_c_proc(gl,"+glLoadMatrixd",{C_POINTER})

public procedure glLoadMatrixd(atom m)
	c_proc(xglLoadMatrixd,{m})
end procedure

public constant xglLoadMatrixf = define_c_proc(gl,"+glLoadMatrixf",{C_POINTER})

public procedure glLoadMatrixf(atom m)
	c_proc(xglLoadMatrixf,{m})
end procedure

public constant xglLoadName = define_c_proc(gl,"+glLoadName",{GLuint})

public procedure glLoadName(atom name)
	c_proc(xglLoadName,{name})
end procedure

public constant xglLogicOp = define_c_proc(gl,"+glLogicOp",{GLenum})

public procedure glLogicOp(atom opcode)
	c_proc(xglLogicOp,{opcode})
end procedure

public constant xglMap1d = define_c_proc(gl,"+glMap1d",{GLenum,GLdouble,GLdouble,GLint,GLint,C_POINTER})

public procedure glMap1d(atom target,atom u1,atom u2,atom stride,atom order,sequence points)
	c_proc(xglMap1d,{target,u1,u2,stride,order,points})
end procedure

public constant xglMap1f = define_c_proc(gl,"+glMap1f",{GLenum,GLfloat,GLfloat,GLint,GLint,C_POINTER})

public procedure glMap1f(atom target,atom u1,atom u2,atom stride,atom order,sequence points)
	c_proc(xglMap1f,{target,u1,u2,stride,order,points})
end procedure

public constant xglMap2d = define_c_proc(gl,"+glMap2d",{GLenum,GLdouble,GLdouble,GLint,GLint,GLdouble,GLdouble,GLint,GLint,C_POINTER})

public procedure glMap2d(atom target,atom u1,atom u2,atom ustride,atom uorder,atom v1,atom v2,atom vstride,atom vorder,sequence points)
	c_proc(xglMap2d,{target,u1,u2,ustride,uorder,v1,v2,vstride,vorder,points})
end procedure

public constant xglMap2f = define_c_proc(gl,"+glMap2f",{GLenum,GLfloat,GLfloat,GLint,GLint,GLfloat,GLfloat,GLint,GLint,C_POINTER})

public procedure glMap2f(atom target,atom u1,atom u2,atom ustride,atom uorder,atom v1,atom v2,atom vstride,atom vorder,sequence points)
	c_proc(xglMap2f,{target,u1,u2,ustride,uorder,v1,v2,vstride,vorder,points})
end procedure

public constant xglMapGrid1d = define_c_proc(gl,"+glMapGrid1d",{GLint,GLdouble,GLdouble})

public procedure glMapGrid1d(atom un,atom u1,atom u2)
	c_proc(xglMapGrid1d,{un,u1,u2})
end procedure

public constant xglMapGrid1f = define_c_proc(gl,"+glMapGrid1f",{GLint,GLfloat,GLfloat})

public procedure glMapGrid1f(atom un,atom u1,atom u2)
	c_proc(xglMapGrid1f,{un,u1,u2})
end procedure

public constant xglMapGrid2d = define_c_proc(gl,"+glMapGrid2d",{GLint,GLdouble,GLdouble,GLint,GLdouble,GLdouble})

public procedure glMapGrid2d(atom un,atom u1,atom u2,atom vn,atom v1,atom v2)
	c_proc(xglMapGrid2d,{un,u1,u2,vn,v1,v2})
end procedure

public constant xglMapGrid2f = define_c_proc(gl,"+glMapGrid2f",{GLint,GLfloat,GLfloat,GLint,GLfloat,GLfloat})

public procedure glMapGrid2f(atom un,atom u1,atom u2,atom vn,atom v1,atom v2)
	c_proc(xglMapGrid2f,{un,u1,u2,vn,v1,v2})
end procedure

public constant xglMaterialf = define_c_proc(gl,"+glMaterialf",{GLenum,GLenum,GLfloat})

public procedure glMaterialf(atom face,atom pname,atom param)
	c_proc(xglMaterialf,{face,pname,param})
end procedure

public constant xglMaterialfv = define_c_proc(gl,"+glMaterialfv",{GLenum,GLenum,C_POINTER})

public procedure glMaterialfv(atom face,atom pname,sequence params)
	atom pparams = allocate_data(sizeof(C_FLOAT) * length(params))
	poke4(pparams,params)
	
	c_proc(xglMaterialfv,{face,pname,pparams})
	
	free(pparams)
end procedure

public constant xglMateriali = define_c_proc(gl,"+glMateriali",{GLenum,GLenum,GLint})

public procedure glMateriali(atom face,atom pname,atom param)
	c_proc(xglMateriali,{face,pname,param})
end procedure

public constant xglMaterialiv = define_c_proc(gl,"+glMaterialiv",{GLenum,GLenum,C_POINTER})

public procedure glMaterialiv(atom face,atom pname,sequence params)
	c_proc(xglMaterialiv,{face,pname,params})
end procedure

--public constant xglMatrixMode = define_c_proc(gl,"+glMatrixMode",{GLenum})

--public procedure glMatrixMode(atom mode)
--	c_proc(xglMatrixMode,{mode})
--end procedure

public constant xglMultMatrixd = define_c_proc(gl,"+glMultMatrixd",{C_POINTER})

public procedure glMultMatrixd(atom m)
	c_proc(xglMultMatrixd,{m})
end procedure

public constant xglMultMatrixf = define_c_proc(gl,"+glMultMatrixf",{C_POINTER})

public procedure glMultMatrixf(atom m)
	c_proc(xglMultMatrixf,{m})
end procedure

public constant xglNewList = define_c_proc(gl,"+glNewList",{GLuint,GLenum})

public procedure glNewList(atom _list,atom mode)
	c_proc(xglNewList,{_list,mode})
end procedure

public constant xglNormal3b = define_c_proc(gl,"+glNormal3b",{GLbyte,GLbyte,GLbyte})

public procedure glNormal3b(atom nx,atom ny,atom nz)
	c_proc(xglNormal3b,{nx,ny,nz})
end procedure

public constant xglNormal3bv = define_c_proc(gl,"+glNormal3bv",{C_POINTER})

public procedure glNormal3bv(atom v)
	c_proc(xglNormal3bv,{v})
end procedure

public constant xglNormal3d = define_c_proc(gl,"+glNormal3d",{GLdouble,GLdouble,GLdouble})

public procedure glNormal3d(atom nx,atom ny,atom nz)
	c_proc(xglNormal3d,{nx,ny,nz})
end procedure

public constant xglNormal3dv = define_c_proc(gl,"+glNormal3dv",{C_POINTER})

public procedure glNormal3dv(atom v)
	c_proc(xglNormal3dv,{v})
end procedure

public constant xglNormal3f = define_c_proc(gl,"+glNormal3f",{GLfloat,GLfloat,GLfloat})

public procedure glNormal3f(atom nx,atom ny,atom nz)
	c_proc(xglNormal3f,{nx,ny,nz})
end procedure

public constant xglNormal3fv = define_c_proc(gl,"+glNormal3fv",{C_POINTER})

public procedure glNormal3fv(atom v)
	c_proc(xglNormal3fv,{v})
end procedure

public constant xglNormal3i = define_c_proc(gl,"+glNormal3i",{GLint,GLint,GLint})

public procedure glNormal3i(atom nx,atom ny,atom nz)
	c_proc(xglNormal3i,{nx,ny,nz})
end procedure

public constant xglNormal3iv = define_c_proc(gl,"+glNormal3iv",{C_POINTER})

public procedure glNormal3iv(atom v)
	c_proc(xglNormal3iv,{v})
end procedure

public constant xglNormal3s = define_c_proc(gl,"+glNormal3s",{GLshort,GLshort,GLshort})

public procedure glNormal3s(atom nx,atom ny,atom nz)
	c_proc(xglNormal3s,{nx,ny,nz})
end procedure

public constant xglNormal3sv = define_c_proc(gl,"+glNormal3sv",{C_POINTER})

public procedure glNormal3sv(atom v)
	c_proc(xglNormal3sv,{v})
end procedure

public constant xglNormalPointer = define_c_proc(gl,"+glNormalPointer",{GLenum,GLsizei,C_POINTER})

public procedure glNormalPointer(atom xtype,atom stride,object ptr)
	c_proc(xglNormalPointer,{xtype,stride,ptr})
end procedure

public constant xglOrtho = define_c_proc(gl,"+glOrtho",{GLdouble,GLdouble,GLdouble,GLdouble,GLdouble,GLdouble})

public procedure glOrtho(atom left,atom right,atom bottom,atom top,atom zNear,atom zFar)
	c_proc(xglOrtho,{left,right,bottom,top,zNear,zFar})
end procedure

public constant xglPassThrough = define_c_proc(gl,"+glPassThrough",{GLfloat})

public procedure glPassThrough(atom xtoken)
	c_proc(xglPassThrough,{xtoken})
end procedure

public constant xglPixelMapfv = define_c_proc(gl,"+glPixelMapfv",{GLenum,GLsizei,C_POINTER})

public procedure glPixelMapfv(atom xmap,atom mapsize,object values)
	c_proc(xglPixelMapfv,{xmap,mapsize,values})
end procedure

public constant xglPixelMapuiv = define_c_proc(gl,"+glPixelMapuiv",{GLenum,GLsizei,C_POINTER})

public procedure glPixelMapuiv(atom xmap,atom mapsize,object values)
	c_proc(xglPixelMapuiv,{xmap,mapsize,values})
end procedure

public constant xglPixelMapusv = define_c_proc(gl,"+glPixelMapusv",{GLenum,GLsizei,C_POINTER})

public procedure glPixelMapusv(atom xmap,atom mapsize,object values)
	c_proc(xglPixelMapusv,{xmap,mapsize,values})
end procedure

public constant xglPixelStoref = define_c_proc(gl,"+glPixelStoref",{GLenum,GLfloat})

public procedure glPixelStoref(atom pname,atom param)
	c_proc(xglPixelStoref,{pname,param})
end procedure

public constant xglPixelStorei = define_c_proc(gl,"+glPixelStorei",{GLenum,GLint})

public procedure glPixelStorei(atom pname,atom param)
	c_proc(xglPixelStorei,{pname,param})
end procedure

public constant xglPixelTransferf = define_c_proc(gl,"+glPixelTransferf",{GLenum,GLfloat})

public procedure glPixelTransferf(atom pname,atom param)
	c_proc(xglPixelTransferf,{pname,param})
end procedure

public constant xglPixelTransferi = define_c_proc(gl,"+glPixelTransferi",{GLenum,GLint})

public procedure glPixelTransferi(atom pname,atom param)
	c_proc(xglPixelTransferi,{pname,param})	
end procedure

public constant xglPixelZoom = define_c_proc(gl,"+glPixelZoom",{GLfloat,GLfloat})

public procedure glPixelZoom(atom xfactor,atom yfactor)
	c_proc(xglPixelZoom,{xfactor,yfactor})
end procedure

public constant xglPointSize = define_c_proc(gl,"+glPointSize",{GLfloat})

public procedure glPointSize(atom size)
	c_proc(xglPointSize,{size})
end procedure

public constant xglPolygonMode = define_c_proc(gl,"+glPolygonMode",{GLenum,GLenum})

public procedure glPolygonMode(atom face,atom mode)
	c_proc(xglPolygonMode,{face,mode})
end procedure

public constant xglPolygonOffset = define_c_proc(gl,"+glPolygonOffset",{GLfloat,GLfloat})

public procedure glPolygonOffset(atom factor,atom units)
	c_proc(xglPolygonOffset,{factor,units})
end procedure

public constant xglPolygonStipple = define_c_proc(gl,"+glPolygonStipple",{C_POINTER})

public procedure glPolygonStipple(atom mask)
	c_proc(xglPolygonStipple,{mask})
end procedure

public constant xglPopAttrib = define_c_proc(gl,"+glPopAttrib",{})

public procedure glPopAttrib()
	c_proc(xglPopAttrib,{})
end procedure

public constant xglPopClientAttrib = define_c_proc(gl,"+glPopClientAttrib",{})

public procedure glPopClientAttrib()
	c_proc(xglPopClientAttrib,{})
end procedure

public constant xglPopMatrix = define_c_proc(gl,"+glPopMatrix",{})

public procedure glPopMatrix()
	c_proc(xglPopMatrix,{})
end procedure

public constant xglPopName = define_c_proc(gl,"+glPopName",{})

public procedure glPopName()
	c_proc(xglPopName,{})
end procedure

public constant xglPrioritizeTextures = define_c_proc(gl,"+glPrioritizeTextures",{GLsizei,C_POINTER,C_POINTER})

public procedure glPrioritizeTextures(atom n,sequence textures,sequence priorities)
	atom p_textures = allocate(textures)
	atom p_priorities = allocate(priorities)
	c_proc(xglPrioritizeTextures,{n,p_textures,p_priorities})
	free(p_textures)
	free(p_priorities)
end procedure

public constant xglPushAttrib = define_c_proc(gl,"+glPushAttrib",{GLbitfield})

public procedure glPushAttrib(atom mask)
	c_proc(xglPushAttrib,{mask})
end procedure

public constant xglPushClientAttrib = define_c_proc(gl,"+glPushClientAttrib",{GLbitfield})

public procedure glPushClientAttrib(atom mask)
	c_proc(xglPushClientAttrib,{mask})
end procedure

public constant xglPushMatrix = define_c_proc(gl,"+glPushMatrix",{})

public procedure glPushMatrix()
	c_proc(xglPushMatrix,{})
end procedure

public constant xglPushName = define_c_proc(gl,"+glPushName",{GLuint})

public procedure glPushName(atom name)
	c_proc(xglPushName,{name})
end procedure

public constant xglRasterPos2d = define_c_proc(gl,"+glRasterPos2d",{GLdouble,GLdouble})

public procedure glRasterPos2d(atom x,atom y)
	c_proc(xglRasterPos2d,{x,y})
end procedure

public constant xglRasterPos2dv = define_c_proc(gl,"+glRasterPos2dv",{C_POINTER})

public procedure glRasterPos2dv(atom v)
	c_proc(xglRasterPos2dv,{v})
end procedure

public constant xglRasterPos2f = define_c_proc(gl,"+glRasterPos2f",{GLfloat,GLfloat})

public procedure glRasterPos2f(atom x,atom y)
	c_proc(xglRasterPos2f,{x,y})
end procedure

public constant xglRasterPos2fv = define_c_proc(gl,"+glRasterPos2fv",{C_POINTER})

public procedure glRasterPos2fv(atom v)
	c_proc(xglRasterPos2fv,{v})
end procedure

public constant xglRasterPos2i = define_c_proc(gl,"+glRasterPos2i",{GLint,GLint})

public procedure glRasterPos2i(atom x,atom y)
	c_proc(xglRasterPos2i,{x,y})
end procedure

public constant xglRasterPos2iv = define_c_proc(gl,"+glRasterPos2iv",{C_POINTER})

public procedure glRasterPos2iv(atom v)
	c_proc(xglRasterPos2iv,{v})
end procedure

public constant xglRasterPos2s = define_c_proc(gl,"+glRasterPos2s",{GLshort,GLshort})

public procedure glRasterPos2s(atom x,atom y)
	c_proc(xglRasterPos2s,{x,y})
end procedure

public constant xglRasterPos2sv = define_c_proc(gl,"+glRasterPos2sv",{C_POINTER})

public procedure glRasterPos2sv(atom v)
	c_proc(xglRasterPos2sv,{v})
end procedure

public constant xglRasterPos3d = define_c_proc(gl,"+glRasterPos3d",{GLdouble,GLdouble,GLdouble})

public procedure glRasterPos3d(atom x,atom y,atom z)
	c_proc(xglRasterPos3d,{x,y,z})
end procedure

public constant xglRasterPos3dv = define_c_proc(gl,"+glRasterPos3dv",{C_POINTER})

public procedure glRasterPos3dv(atom v)
	c_proc(xglRasterPos3dv,{v})
end procedure

public constant xglRasterPos3f = define_c_proc(gl,"+glRasterPos3f",{GLfloat,GLfloat,GLfloat})

public procedure glRasterPos3f(atom x,atom y,atom z)
	c_proc(xglRasterPos3f,{x,y,z})
end procedure

public constant xglRasterPos3fv = define_c_proc(gl,"+glRasterPos3fv",{C_POINTER})

public procedure glRasterPos3fv(atom v)
	c_proc(xglRasterPos3fv,{v})
end procedure

public constant xglRasterPos3i = define_c_proc(gl,"+glRasterPos3i",{GLint,GLint,GLint})

public procedure glRasterPos3i(atom x,atom y,atom z)
	c_proc(xglRasterPos3i,{x,y,z})
end procedure

public constant xglRasterPos3iv = define_c_proc(gl,"+glRasterPos3iv",{C_POINTER})

public procedure glRasterPos3iv(atom v)
	c_proc(xglRasterPos3iv,{v})
end procedure

public constant xglRasterPos3s = define_c_proc(gl,"+glRasterPos3s",{GLshort,GLshort,GLshort})

public procedure glRasterPos3s(atom x,atom y,atom z)
	c_proc(xglRasterPos3s,{x,y,z})
end procedure

public constant xglRasterPos3sv = define_c_proc(gl,"+glRasterPos3sv",{C_POINTER})

public procedure glRasterPos3sv(atom v)
	c_proc(xglRasterPos3sv,{v})
end procedure

public constant xglRasterPos4d = define_c_proc(gl,"+glRasterPos4d",{GLdouble,GLdouble,GLdouble,GLdouble})

public procedure glRasterPos4d(atom x,atom y,atom z,atom w)
	c_proc(xglRasterPos4d,{x,y,z,w})
end procedure

public constant xglRasterPos4dv = define_c_proc(gl,"+glRasterPos4dv",{C_POINTER})

public procedure glRasterPos4dv(atom v)
	c_proc(xglRasterPos4dv,{v})
end procedure

public constant xglRasterPos4f = define_c_proc(gl,"+glRasterPos4f",{GLfloat,GLfloat,GLfloat,GLfloat})

public procedure glRasterPos4f(atom x,atom y,atom z,atom w)
	c_proc(xglRasterPos4f,{x,y,z,w})
end procedure

public constant xglRasterPos4fv = define_c_proc(gl,"+glRasterPos4fv",{C_POINTER})

public procedure glRasterPos4fv(atom v)
	c_proc(xglRasterPos4fv,{v})
end procedure

public constant xglRasterPos4i = define_c_proc(gl,"+glRasterPos4i",{GLint,GLint,GLint,GLint})

public procedure glRasterPos4i(atom x,atom y,atom z,atom w)
	c_proc(xglRasterPos4i,{x,y,z,w})
end procedure

public constant xglRasterPos4iv = define_c_proc(gl,"+glRasterPos4iv",{C_POINTER})

public procedure glRasterPos4iv(atom v)
	c_proc(xglRasterPos4iv,{v})
end procedure

public constant xglRasterPos4s = define_c_proc(gl,"+glRasterPos4s",{GLshort,GLshort,GLshort,GLshort})

public procedure glRasterPos4s(atom x,atom y,atom z,atom w)
	c_proc(xglRasterPos4s,{x,y,z,w})
end procedure

public constant xglRasterPos4sv = define_c_proc(gl,"+glRasterPos4sv",{C_POINTER})

public procedure glRasterPos4sv(atom v)
	c_proc(xglRasterPos4sv,{v})
end procedure

public constant xglReadBuffer = define_c_proc(gl,"+glReadBuffer",{GLenum})

public procedure glReadBuffer(atom mode)
	c_proc(xglReadBuffer,{mode})
end procedure

public constant xglReadPixels = define_c_proc(gl,"+glReadPixels",{GLint,GLint,GLsizei,GLsizei,GLenum,GLenum,C_POINTER})

public procedure glReadPixels(atom x,atom y,atom width,atom height,atom format,atom xtype,sequence pixels)
	c_proc(xglReadPixels,{x,y,width,height,format,xtype,pixels})
end procedure

public constant xglRectd = define_c_proc(gl,"+glRectd",{GLdouble,GLdouble,GLdouble,GLdouble})

public procedure glRectd(atom x1,atom y1,atom x2,atom y2)
	c_proc(xglRectd,{x1,y1,x2,y2})
end procedure

public constant xglRectdv = define_c_proc(gl,"+glRectdv",{C_POINTER,C_POINTER})

public procedure glRectdv(atom v1,atom v2)
	c_proc(xglRectdv,{v1,v2})
end procedure

public constant xglRectf = define_c_proc(gl,"+glRectf",{GLfloat,GLfloat,GLfloat,GLfloat})

public procedure glRectf(atom x1,atom y1,atom x2,atom y2)
	c_proc(xglRectf,{x1,y1,x2,y2})
end procedure

public constant xglRectfv = define_c_proc(gl,"+glRectfv",{C_POINTER,C_POINTER})

public procedure glRectfv(atom v1,atom v2)
	c_proc(xglRectfv,{v1,v2})
end procedure

public constant xglRecti = define_c_proc(gl,"+glRecti",{GLint,GLint,GLint,GLint})

public procedure glRecti(atom x1,atom y1,atom x2,atom y2)
	c_proc(xglRecti,{x1,y1,x2,y2})
end procedure

public constant xglRectiv = define_c_proc(gl,"+glRectiv",{C_POINTER,C_POINTER})

public procedure glRectiv(atom v1,atom v2)
	c_proc(xglRectiv,{v1,v2})
end procedure

public constant xglRects = define_c_proc(gl,"+glRects",{GLshort,GLshort,GLshort,GLshort})

public procedure glRects(atom x1,atom y1,atom x2,atom y2)
	c_proc(xglRects,{x1,y1,x2,y2})
end procedure

public constant xglRectsv = define_c_proc(gl,"+glRectsv",{C_POINTER,C_POINTER})

public procedure glRectsv(atom v1,atom v2)
	c_proc(xglRectsv,{v1,v2})
end procedure

public constant xglRenderMode = define_c_func(gl,"+glRenderMode",{GLenum},GLint)

public function glRenderMode(atom mode)
	return c_func(xglRenderMode,{mode})
end function

public constant xglRotated = define_c_proc(gl,"+glRotated",{GLdouble,GLdouble,GLdouble,GLdouble})

public procedure glRotated(atom angle,atom x,atom y,atom z)
	c_proc(xglRotated,{angle,x,y,z})
end procedure

public constant xglRotatef = define_c_proc(gl,"+glRotatef",{GLfloat,GLfloat,GLfloat,GLfloat})

public procedure glRotatef(atom angle,atom x,atom y,atom z)
	c_proc(xglRotatef,{angle,x,y,z})
end procedure

public constant xglScaled = define_c_proc(gl,"+glScaled",{GLdouble,GLdouble,GLdouble})

public procedure glScaled(atom x,atom y,atom z)
	c_proc(xglScaled,{x,y,z})
end procedure

public constant xglScalef = define_c_proc(gl,"+glScalef",{GLfloat,GLfloat,GLfloat})

public procedure glScalef(atom x,atom y,atom z)
	c_proc(xglScalef,{x,y,z})
end procedure

public constant xglScissor = define_c_proc(gl,"+glScissor",{GLint,GLint,GLsizei,GLsizei})

public procedure glScissor(atom x,atom y,atom width,atom height)
	c_proc(xglScissor,{x,y,width,height})
end procedure

public constant xglSelectBuffer = define_c_proc(gl,"+glSelectBuffer",{GLsizei,C_POINTER})

public procedure glSelectBuffer(atom size,object buffer)
	c_proc(xglSelectBuffer,{size,buffer})
end procedure

public constant xglShadeModel = define_c_proc(gl,"+glShadeModel",{GLenum})

public procedure glShadeModel(atom mode)
	c_proc(xglShadeModel,{mode})
end procedure

public constant xglStencilFunc = define_c_proc(gl,"+glStencilFunc",{GLenum,GLint,GLuint})

public procedure glStencilFunc(atom func,atom ref,atom mask)
	c_proc(xglStencilFunc,{func,ref,mask})
end procedure

public constant xglStencilMask = define_c_proc(gl,"+glStencilMask",{GLuint})

public procedure glStencilMask(atom mask)
	c_proc(xglStencilMask,{mask})
end procedure

public constant xglStencilOp = define_c_proc(gl,"+glStencilOp",{GLenum,GLenum,GLenum})

public procedure glStencilOp(atom fail,atom zfail,atom zpass)
	c_proc(xglStencilOp,{fail,zfail,zpass})
end procedure

public constant xglTexCoord1d = define_c_proc(gl,"+glTexCoord1d",{GLdouble})

public procedure glTexCoord1d(atom s)
	c_proc(xglTexCoord1d,{s})
end procedure

public constant xglTexCoord1dv = define_c_proc(gl,"+glTexCoord1dv",{C_POINTER})

public procedure glTexCoord1dv(atom v)
	c_proc(xglTexCoord1dv,{v})
end procedure

public constant xglTexCoord1f = define_c_proc(gl,"+glTexCoord1f",{GLfloat})

public procedure glTexCoord1f(atom s)
	c_proc(xglTexCoord1f,{s})
end procedure

public constant xglTexCoord1fv = define_c_proc(gl,"+glTexCoord1fv",{C_POINTER})

public procedure glTexCoord1fv(atom v)
	c_proc(xglTexCoord1fv,{v})
end procedure

public constant xglTexCoord1i = define_c_proc(gl,"+glTexCoord1i",{GLint})

public procedure glTexCoord1i(atom s)
	c_proc(xglTexCoord1i,{s})
end procedure

public constant xglTexCoord1iv = define_c_proc(gl,"+glTexCoord1iv",{C_POINTER})

public procedure glTexCoord1iv(atom v)
	c_proc(xglTexCoord1iv,{v})
end procedure

public constant xglTexCoord1s = define_c_proc(gl,"+glTexCoord1s",{GLshort})

public procedure glTexCoord1s(atom s)
	c_proc(xglTexCoord1s,{s})
end procedure

public constant xglTexCoord1sv = define_c_proc(gl,"+glTexCoord1sv",{C_POINTER})

public procedure glTexCoord1sv(atom v)
	c_proc(xglTexCoord1sv,{v})
end procedure

public constant xglTexCoord2d = define_c_proc(gl,"+glTexCoord2d",{GLdouble,GLdouble})

public procedure glTexCoord2d(atom s,atom t)
	c_proc(xglTexCoord2d,{s,t})
end procedure

public constant xglTexCoord2dv = define_c_proc(gl,"+glTexCoord2dv",{C_POINTER})

public procedure glTexCoord2dv(atom v)
	c_proc(xglTexCoord2dv,{v})
end procedure

public constant xglTexCoord2f = define_c_proc(gl,"+glTexCoord2f",{GLfloat,GLfloat})

public procedure glTexCoord2f(atom s,atom t)
	c_proc(xglTexCoord2f,{s,t})
end procedure

public constant xglTexCoord2fv = define_c_proc(gl,"+glTexCoord2fv",{C_POINTER})

public procedure glTexCoord2fv(atom v)
	c_proc(xglTexCoord2fv,{v})
end procedure

public constant xglTexCoord2i = define_c_proc(gl,"+glTexCoord2i",{GLint,GLint})

public procedure glTexCoord2i(atom s,atom t)
	c_proc(xglTexCoord2i,{s,t})
end procedure

public constant xglTexCoord2iv = define_c_proc(gl,"+glTexCoord2iv",{C_POINTER})

public procedure glTexCoord2iv(atom v)
	c_proc(xglTexCoord2iv,{v})
end procedure

public constant xglTexCoord2s = define_c_proc(gl,"+glTexCoord2s",{GLshort,GLshort})

public procedure glTexCoord2s(atom s,atom t)
	c_proc(xglTexCoord2s,{s,t})
end procedure

public constant xglTexCoord2sv = define_c_proc(gl,"+glTexCoord2sv",{C_POINTER})

public procedure glTexCoord2sv(atom v)
	c_proc(xglTexCoord2sv,{v})
end procedure

public constant xglTexCoord3d = define_c_proc(gl,"+glTexCoord3d",{GLdouble,GLdouble,GLdouble})

public procedure glTexCoord3d(atom s,atom t,atom r)
	c_proc(xglTexCoord3d,{s,t,r})
end procedure

public constant xglTexCoord3dv = define_c_proc(gl,"+glTexCoord3dv",{C_POINTER})

public procedure glTexCoord3dv(atom v)
	c_proc(xglTexCoord3dv,{v})
end procedure

public constant xglTexCoord3f = define_c_proc(gl,"+glTexCoord3f",{GLfloat,GLfloat,GLfloat})

public procedure glTexCoord3f(atom s,atom t,atom r)
	c_proc(xglTexCoord3f,{s,t,r})
end procedure

public constant xglTexCoord3fv = define_c_proc(gl,"+glTexCoord3fv",{C_POINTER})

public procedure glTexCoord3fv(atom v)
	c_proc(xglTexCoord3fv,{v})
end procedure

public constant xglTexCoord3i = define_c_proc(gl,"+glTexCoord3i",{GLint,GLint,GLint})

public procedure glTexCoord3i(atom s,atom t,atom r)
	c_proc(xglTexCoord3i,{s,t,r})
end procedure

public constant xglTexCoord3iv = define_c_proc(gl,"+glTexCoord3iv",{C_POINTER})

public procedure glTexCoord3iv(atom v)
	c_proc(xglTexCoord3iv,{v})
end procedure

public constant xglTexCoord3s = define_c_proc(gl,"+glTexCoord3s",{GLshort,GLshort,GLshort})

public procedure glTexCoord3s(atom s,atom t,atom r)
	c_proc(xglTexCoord3s,{s,t,r})
end procedure

public constant xglTexCoord3sv = define_c_proc(gl,"+glTexCoord3sv",{C_POINTER})

public procedure glTexCoord3sv(atom v)
	c_proc(xglTexCoord3sv,{v})
end procedure

public constant xglTexCoord4d = define_c_proc(gl,"+glTexCoord4d",{GLdouble,GLdouble,GLdouble,GLdouble})

public procedure glTexCoord4d(atom s,atom t,atom r,atom q)
	c_proc(xglTexCoord4d,{s,t,r,q})
end procedure

public constant xglTexCoord4dv = define_c_proc(gl,"+glTexCoord4dv",{C_POINTER})

public procedure glTexCoord4dv(atom v)
	c_proc(xglTexCoord4dv,{v})
end procedure

public constant xglTexCoord4f = define_c_proc(gl,"+glTexCoord4f",{GLfloat,GLfloat,GLfloat,GLfloat})

public procedure glTexCoord4f(atom s,atom t,atom r,atom q)
	c_proc(xglTexCoord4f,{s,t,r,q})
end procedure

public constant xglTexCoord4fv = define_c_proc(gl,"+glTexCoord4fv",{C_POINTER})

public procedure glTexCoord4fv(atom v)
	c_proc(xglTexCoord4fv,{v})
end procedure

public constant xglTexCoord4i = define_c_proc(gl,"+glTexCoord4i",{GLint,GLint,GLint,GLint})

public procedure glTexCoord4i(atom s,atom t,atom r,atom q)
	c_proc(xglTexCoord4i,{s,t,r,q})
end procedure

public constant xglTexCoord4iv = define_c_proc(gl,"+glTexCoord4iv",{C_POINTER})

public procedure glTexCoord4iv(atom v)
	c_proc(xglTexCoord4iv,{v})
end procedure

public constant xglTexCoord4s = define_c_proc(gl,"+glTexCoord4s",{GLshort,GLshort,GLshort,GLshort})

public procedure glTexCoord4s(atom s,atom t,atom r,atom q)
	c_proc(xglTexCoord4s,{s,t,r,q})
end procedure

public constant xglTexCoord4sv = define_c_proc(gl,"+glTexCoord4sv",{C_POINTER})

public procedure glTexCoord4sv(atom v)
	c_proc(xglTexCoord4sv,{v})
end procedure

public constant xglTexCoordPointer = define_c_proc(gl,"+glTexCoordPointer",{GLint,GLenum,GLsizei,C_POINTER})

public procedure glTexCoordPointer(atom size,atom xtype,atom stride,sequence texCoords)

	if length(texCoords) = 0 then
		puts(1,"Coordinate data is empty!\n")
	end if
	
	atom ptr = allocate_data(sizeof(xtype) * length(texCoords))
	
	for i = 1 to length(texCoords) do
		poke_pointer(ptr + (i - 1) * sizeof(xtype), texCoords[i])
	end for
	
	c_proc(xglTexCoordPointer,{size,xtype,stride,ptr})
	
	free(ptr)
end procedure

public constant xglTexEnvf = define_c_proc(gl,"+glTexEnvf",{GLenum,GLenum,GLfloat})

public procedure glTexEnvf(atom target,atom pname,atom param)
	c_proc(xglTexEnvf,{target,pname,param})
end procedure

public constant xglTexEnvfv = define_c_proc(gl,"+glTexEnvfv",{GLenum,GLenum,C_POINTER})

public procedure glTexEnvfv(atom target,atom pname,sequence params)
	atom ptr = allocate_data(sizeof(GLfloat) * 4)
	
	for i = 1 to 4 do
		poke_pointer(ptr + (i - 1) * sizeof(GLfloat), params[i])
	end for
	
	c_proc(xglTexEnvfv,{target,pname,ptr})
	
	free(ptr)
end procedure

public constant xglTexEnvi = define_c_proc(gl,"+glTexEnvi",{GLenum,GLenum,GLint})

public procedure glTexEnvi(atom target,atom pname,atom param)
	c_proc(xglTexEnvi,{target,pname,param})
end procedure

public constant xglTexEnviv = define_c_proc(gl,"+glTexEnviv",{GLenum,GLenum,C_POINTER})

public procedure glTexEnviv(atom target,atom pname,sequence params)
	atom ptr = allocate_data(sizeof(GLint) * 4)
	
	for i = 1 to 4 do
		poke_pointer(ptr + (i - 1) * sizeof(GLint), params[i])
	end for
	
	c_proc(xglTexEnviv,{target,pname,ptr})
	
	free(ptr)
end procedure

public constant xglTexGend = define_c_proc(gl,"+glTexGend",{GLenum,GLenum,GLdouble})

public procedure glTexGend(atom coord,atom pname,atom param)
	c_proc(xglTexGend,{coord,pname,param})
end procedure

public constant xglTexGendv = define_c_proc(gl,"+glTexGendv",{GLenum,GLenum,C_POINTER})

public procedure glTexGendv(atom coord,atom pname,sequence params)
	atom ptr = allocate_data(sizeof(GLdouble) * 4)
	
	for i = 1 to 4 do
		poke_pointer(ptr + (i - 1) * sizeof(GLdouble), params[i])
	end for
	
	c_proc(xglTexGendv,{coord,pname,ptr})
	
	free(ptr)
end procedure

public constant xglTexGenf = define_c_proc(gl,"+glTexGenf",{GLenum,GLenum,GLfloat})

public procedure glTexGenf(atom coord,atom pname,atom param)
	c_proc(xglTexGenf,{coord,pname,param})
end procedure

public constant xglTexGenfv = define_c_proc(gl,"+glTexGenfv",{GLenum,GLenum,C_POINTER})

public procedure glTexGenfv(atom coord,atom pname,sequence params)
	atom ptr = allocate_data(sizeof(GLfloat) * 4)
	
	for i = 1 to 4 do
		poke_pointer(ptr + (i - 1) * sizeof(GLfloat), params[i])
	end for
	
	c_proc(xglTexGenfv,{coord,pname,ptr})
	
	free(ptr)
end procedure

public constant xglTexGeni = define_c_proc(gl,"+glTexGeni",{GLenum,GLenum,GLint})

public procedure glTexGeni(atom coord,atom pname,atom param)
	c_proc(xglTexGeni,{coord,pname,param})
end procedure

public constant xglTexGeniv = define_c_proc(gl,"+glTexGeniv",{GLenum,GLenum,C_POINTER})

public procedure glTexGeniv(atom coord,atom pname,sequence params)
	atom ptr = allocate_data(sizeof(GLint) * 4)
	
	for i = 1 to 4 do
		poke_pointer(ptr + (i - 1) * sizeof(GLint), params[i])
	end for
	
	c_proc(xglTexGeniv,{coord,pname,ptr})
	
	free(ptr)
end procedure

public constant xglTexImage1D = define_c_proc(gl,"+glTexImage1D",{GLenum,GLint,GLint,GLsizei,GLint,GLenum,GLenum,C_POINTER})

public procedure glTexImage1D(atom target,atom level,atom internalformat,atom width,atom border,atom format,atom xtype,sequence pixels)
	atom ptr = allocate_data(sizeof(xtype) * width)
	
	for i = 1 to width do
		poke_pointer(ptr + (i - 1) * sizeof(xtype), pixels[i])
	end for
	
	c_proc(xglTexImage1D,{target,level,internalformat,width,border,format,xtype,ptr})
	
	free(ptr)
end procedure

public constant xglTexImage2D = define_c_proc(gl,"+glTexImage2D",{GLenum,GLint,GLint,GLsizei,GLsizei,GLint,GLenum,GLenum,C_POINTER})

public procedure glTexImage2D(atom target,atom level,atom internalformat,atom width,atom height,atom border,atom format,atom xtype,sequence pixels)
	atom ptr = allocate_data(sizeof(xtype) * width * height)
	
	for i = 1 to width * height do
		poke_pointer(ptr + (i - 1) * sizeof(xtype), pixels[i])
	end for
	
	c_proc(xglTexImage2D,{target,level,internalformat,width,height,border,format,xtype,ptr})
	
	free(ptr)
end procedure

public constant xglTexParameterf = define_c_proc(gl,"+glTexParameterf",{GLenum,GLenum,GLfloat})

public procedure glTexParameterf(atom target,atom pname,atom param)
	c_proc(xglTexParameterf,{target,pname,param})
end procedure

public constant xglTexParameterfv = define_c_proc(gl,"+glTexParameterfv",{GLenum,GLenum,C_POINTER})

public procedure glTexParameterfv(atom target,atom pname,sequence params)
	c_proc(xglTexParameterfv,{target,pname,params})
end procedure

public constant xglTexParameteri = define_c_proc(gl,"+glTexParameteri",{GLenum,GLenum,GLint})

public procedure glTexParameteri(atom target,atom pname,atom param)
	c_proc(xglTexParameteri,{target,pname,param})
end procedure

public constant xglTexParameteriv = define_c_proc(gl,"+glTexParameteriv",{GLenum,GLenum,C_POINTER})

public procedure glTexParameteriv(atom target,atom pname,sequence params)
	c_proc(xglTexParameteriv,{target,pname,params})
end procedure

public constant xglTexSubImage1D = define_c_proc(gl,"+glTexSubImage1D",{GLenum,GLint,GLint,GLsizei,GLenum,GLenum,C_POINTER})

public procedure glTexSubImage1D(atom target,atom level,atom xoffset,atom width,atom format,atom xtype,sequence pixels)
	atom ptr = allocate_data(sizeof(xtype) * width)
	
	for i = 1 to width do
		poke_pointer(ptr + (i - 1) * sizeof(xtype), pixels[i])
	end for
	
	c_proc(xglTexSubImage1D,{target,level,xoffset,width,format,xtype,ptr})
	
	free(ptr)
end procedure

public constant xglTexSubImage2D = define_c_proc(gl,"+glTexSubImage2D",{GLenum,GLint,GLint,GLint,GLsizei,GLsizei,GLenum,GLenum,C_POINTER})

public procedure glTexSubImage2D(atom target,atom level,atom xoffset,atom yoffset,atom width,atom height,atom format,atom xtype,sequence pixels)
	atom ptr = allocate_data(sizeof(xtype) * width * height)
	
	for i = 1 to width * height do
		poke_pointer(ptr + (i - 1) * sizeof(xtype), pixels[i])
	end for
	
	c_proc(xglTexSubImage2D,{target,level,xoffset,yoffset,width,height,format,xtype,ptr})
	
	free(ptr)
end procedure

public constant xglTranslated = define_c_proc(gl,"+glTranslated",{GLdouble,GLdouble,GLdouble})

public procedure glTranslated(atom x,atom y,atom z)
	c_proc(xglTranslated,{x,y,z})
end procedure

public constant xglTranslatef = define_c_proc(gl,"+glTranslatef",{GLfloat,GLfloat,GLfloat})

public procedure glTranslatef(atom x,atom y,atom z)
	c_proc(xglTranslatef,{x,y,z})
end procedure

public constant xglVertex2d = define_c_proc(gl,"+glVertex2d",{GLdouble,GLdouble})

public procedure glVertex2d(atom x,atom y)
	c_proc(xglVertex2d,{x,y})
end procedure

public constant xglVertex2dv = define_c_proc(gl,"+glVertex2dv",{C_POINTER})

public procedure glVertex2dv(atom v)
	c_proc(xglVertex2dv,{v})
end procedure

public constant xglVertex2f = define_c_proc(gl,"+glVertex2f",{GLfloat,GLfloat})

public procedure glVertex2f(atom x,atom y)
	c_proc(xglVertex2f,{x,y})
end procedure

public constant xglVertex2fv = define_c_proc(gl,"+glVertex2fv",{C_POINTER})

public procedure glVertex2fv(atom v)
	c_proc(xglVertex2fv,{v})
end procedure

public constant xglVertex2i = define_c_proc(gl,"+glVertex2i",{GLint,GLint})

public procedure glVertex2i(atom x,atom y)
	c_proc(xglVertex2i,{x,y})
end procedure

public constant xglVertex2iv = define_c_proc(gl,"+glVertex2iv",{C_POINTER})

public procedure glVertex2iv(atom v)
	c_proc(xglVertex2iv,{v})
end procedure

public constant xglVertex2s = define_c_proc(gl,"+glVertex2s",{GLshort,GLshort})

public procedure glVertex2s(atom x,atom y)
	c_proc(xglVertex2s,{x,y})
end procedure

public constant xglVertex2sv = define_c_proc(gl,"+glVertex2sv",{C_POINTER})

public procedure glVertex2sv(atom v)
	c_proc(xglVertex2sv,{v})
end procedure

public constant xglVertex3d = define_c_proc(gl,"+glVertex3d",{GLdouble,GLdouble,GLdouble})

public procedure glVertex3d(atom x,atom y,atom z)
	c_proc(xglVertex3d,{x,y,z})
end procedure

public constant xglVertex3dv = define_c_proc(gl,"+glVertex3dv",{C_POINTER})

public procedure glVertex3dv(atom v)
	c_proc(xglVertex3dv,{v})
end procedure

public constant xglVertex3f = define_c_proc(gl,"+glVertex3f",{GLfloat,GLfloat,GLfloat})

public procedure glVertex3f(atom x,atom y,atom z)
	c_proc(xglVertex3f,{x,y,z})
end procedure

public constant xglVertex3fv = define_c_proc(gl,"+glVertex3fv",{C_POINTER})

public procedure glVertex3fv(atom v)
	c_proc(xglVertex3fv,{v})
end procedure

public constant xglVertex3i = define_c_proc(gl,"+glVertex3i",{GLint,GLint,GLint})

public procedure glVertex3i(atom x,atom y,atom z)
	c_proc(xglVertex3i,{x,y,z})
end procedure

public constant xglVertex3iv = define_c_proc(gl,"+glVertex3iv",{C_POINTER})

public procedure glVertex3iv(atom v)
	c_proc(xglVertex3iv,{v})
end procedure

public constant xglVertex3s = define_c_proc(gl,"+glVertex3s",{GLshort,GLshort,GLshort})

public procedure glVertex3s(atom x,atom y,atom z)
	c_proc(xglVertex3s,{x,y,z})
end procedure

public constant xglVertex3sv = define_c_proc(gl,"+glVertex3sv",{C_POINTER})

public procedure glVertex3sv(atom v)
	c_proc(xglVertex3sv,{v})
end procedure

public constant xglVertex4d = define_c_proc(gl,"+glVertex4d",{GLdouble,GLdouble,GLdouble,GLdouble})

public procedure glVertex4d(atom x,atom y,atom z,atom w)
	c_proc(xglVertex4d,{x,y,z,w})
end procedure

public constant xglVertex4dv = define_c_proc(gl,"+glVertex4dv",{C_POINTER})

public procedure glVertex4dv(atom v)
	c_proc(xglVertex4dv,{v})
end procedure

public constant xglVertex4f = define_c_proc(gl,"+glVertex4f",{GLfloat,GLfloat,GLfloat,GLfloat})

public procedure glVertex4f(atom x,atom y,atom z,atom w)
	c_proc(xglVertex4f,{x,y,z,w})
end procedure

public constant xglVertex4fv = define_c_proc(gl,"+glVertex4fv",{C_POINTER})

public procedure glVertex4fv(atom v)
	c_proc(xglVertex4fv,{v})
end procedure

public constant xglVertex4i = define_c_proc(gl,"+glVertex4i",{GLint,GLint,GLint,GLint})

public procedure glVertex4i(atom x,atom y,atom z,atom w)
	c_proc(xglVertex4i,{x,y,z,w})
end procedure

public constant xglVertex4iv = define_c_proc(gl,"+glVertex4iv",{C_POINTER})

public procedure glVertex4iv(atom v)
	c_proc(xglVertex4iv,{v})
end procedure

public constant xglVertex4s = define_c_proc(gl,"+glVertex4s",{GLshort,GLshort,GLshort,GLshort})

public procedure glVertex4s(atom x,atom y,atom z,atom w)
	c_proc(xglVertex4s,{x,y,z,w})
end procedure

public constant xglVertex4sv = define_c_proc(gl,"+glVertex4sv",{C_POINTER})

public procedure glVertex4sv(atom v)
	c_proc(xglVertex4sv,{v})
end procedure

public constant xglVertexPointer = define_c_proc(gl,"+glVertexPointer",{GLint,GLenum,GLsizei,C_POINTER})

public procedure glVertexPointer(atom size,atom xtype,atom stride,object ptr)
	c_proc(xglVertexPointer,{size,xtype,stride,ptr})
end procedure

public constant xglViewport = define_c_proc(gl,"+glViewport",{GLint,GLint,GLsizei,GLsizei})

public procedure glViewport(atom x,atom y,atom width,atom height)
	c_proc(xglViewport,{x,y,width,height})
end procedure

public constant xglEndList = define_c_proc(gl,"+glEndList",{})

public procedure glEndList()
	c_proc(xglEndList,{})
end procedure
­9.16