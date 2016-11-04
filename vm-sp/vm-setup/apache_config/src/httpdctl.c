#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <pwd.h>
#include <stdio.h>
#include <strings.h>
#include <stdlib.h>

main(argc, argv)
int argc;
char *argv[];
{
  struct passwd *p;
  char *path = "/usr/sbin/httpd";

  /* Make sure path is owned by root */
  struct stat st;
  if (stat(path, &st) != 0) {
    fprintf(stderr,"Error: unable to stat %s\n", path);
    exit(1);
  }

  if (st.st_uid != 0) {
    fprintf(stderr,"Error: %s is not owned by root\n", path);
    exit(1);
  }

  /* Get the real UID */
  p = getpwuid(getuid());
  if (p == NULL) exit(1);

  /* Only allow the correct user to run this */
  if (strcmp("SED_SERVICE_USER_ACCOUNT_NAME", p->pw_name) != 0 &&
      strcmp("root", p->pw_name) != 0) {
    fprintf(stderr, "Invalid user!\n");
    exit(1);
  }

  /* Set uid to root */
  setuid(0);

  /* Execute program */
  execv(path, argv);
}

