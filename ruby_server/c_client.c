#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>

int main(int ac, char **av[]) {
    int sock;
    struct sockaddr_in addr;
    struct hostent *host;
    char buf[128];
    int n;

    sock = socket(PF_INET, SOCK_STREAM, 0);
    addr.sin_family = AF_INET;
    host = gethostbyname("localhost");
    memcpy(&addr.sin_addr, host->h_addr, sizeof(addr.sin_addr));
    addr.sin_port = htons(12345);

    connect(sock, (struct sockaddr*)&addr, sizeof(addr));
    n = read(sock, buf, sizeof(buf));
    buf[n] = '\0';
    if (n > 0) {
        fputs(buf, stdout);
    }
    return 0;
} 
