// g++ -o libPlotPanel.so -shared -Wl,-soname,libPlotPanel.so -I/usr/lib/jvm/java-6-openjdk-i386/include/ -I/usr/lib/jvm/java-6-openjdk-i386/include/linux -L /usr/lib/jvm/java-6-openjdk-i386/jre/lib/i386 PlotPanel.cpp -static -lc -ljawt -lGL

#include <cassert>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>

#include <GL/gl.h>
#include <GL/glx.h>
#include <GL/glu.h>

#include "jawt_md.h"
#include "PlotPanels_PlotPanel.h"

GLXContext cx[10];
Display *display[10];
GLXDrawable window[10];
JAWT awt;

int getID() {
    return 0; // !!
}

JNIEXPORT jint JNICALL Java_PlotPanels_PlotPanel_initializeGL(JNIEnv *env, jobject panel) {
    int ID = getID();

  XInitThreads();
  bool doubleBuffer = true;

  static int dblBuf[] = {GLX_RGBA, GLX_RED_SIZE, 8, GLX_GREEN_SIZE, 8, GLX_BLUE_SIZE, 8, GLX_DEPTH_SIZE, 8, GLX_DOUBLEBUFFER, None};

  JAWT_DrawingSurface *ds;
  JAWT_DrawingSurfaceInfo *dsi;
  JAWT_X11DrawingSurfaceInfo *dsi_win;
  jboolean result;

  awt.version = JAWT_VERSION_1_3;
  result = JAWT_GetAWT(env, &awt);
  assert(result != JNI_FALSE);

  ds = awt.GetDrawingSurface(env, panel);
  assert(ds != NULL);

  ds->Lock(ds);

  dsi = ds->GetDrawingSurfaceInfo(ds);
  dsi_win = (JAWT_X11DrawingSurfaceInfo *) dsi->platformInfo;

  display[ID] = dsi_win->display;
  window[ID] = dsi_win->drawable;

  if (!display[ID]) {
    std::cerr << "No display" << std::endl;
    exit(1);
  }

  if (!window) {
    std::cerr << "No drawable" << std::endl;
    return ID;
  }

  XVisualInfo *vi = glXChooseVisual(display[ID], DefaultScreen(display[ID]), dblBuf);
  if (vi == NULL) {
    std::cerr << "Couldn't do double-buffered" << std::endl;
    return ID;
  }

  cx[ID] = glXCreateContext(display[ID], vi, None, true);
  if (cx[ID] == NULL) {
    std::cerr << "Couldn't create context" << std::endl;
    exit(-1);
  }

  glXMakeCurrent(display[ID], window[ID], cx[ID]);

  ds->Unlock(ds);
  return ID;
}

JNIEXPORT void JNICALL Java_PlotPanels_PlotPanel_paintOpenGLVoid(JNIEnv *env, jobject panel, jint ID) {
  JAWT_DrawingSurface *ds;
  ds = awt.GetDrawingSurface(env, panel);
  ds->Lock(ds);

  glXMakeCurrent(display[ID], window[ID], cx[ID]);

  glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
  glClear(GL_COLOR_BUFFER_BIT);

  glPushMatrix();
  glBegin( GL_TRIANGLES );
  glColor3f(1.0f, 0.0f, 0.0f);
  glVertex2f(0.0f, 1.0f);
  glColor3f(0.0f, 1.0f, 0.0f);
  glVertex2f(0.87f, -0.5f);
  glColor3f(0.0f, 0.0f, 1.0f);
  glVertex2f(-0.87f, -0.5f);
  glEnd();
  glPopMatrix();

  glFlush();

  glXSwapBuffers(display[ID], window[ID]);

  ds->Unlock(ds);
}

JNIEXPORT void JNICALL Java_PlotPanels_PlotPanel_releaseGL(JNIEnv *env, jobject panel) {
    int ID = 0; // !!
  glXMakeCurrent(display[ID], None, NULL);
  glXDestroyContext(display[ID], cx[ID]);
}
