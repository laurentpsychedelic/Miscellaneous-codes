#include <windows.h>
#include <stdio.h>
#include "jsmn/jsmn.h"

const char* JSMNTypeToString(const int type) {
    static const char* JSMN_PRIMITIVE_STR = "PRIMITIVE";
    static const char* JSMN_OBJECT_STR = "OBJECT";
    static const char* JSMN_ARRAY_STR = "ARRAY";
    static const char* JSMN_STRING_STR = "STRING";
    static const char* UNKNOWN_TYPE_STR = "UNKNOWN_TYPE";
    switch (type) {
    case JSMN_PRIMITIVE:
        return JSMN_PRIMITIVE_STR;
    case JSMN_OBJECT:
        return JSMN_OBJECT_STR;
    case JSMN_ARRAY:
        return JSMN_ARRAY_STR;
    case JSMN_STRING:
        return JSMN_STRING_STR;
    default:
        return UNKNOWN_TYPE_STR;
    }
}

int main(int argc, char *argv[]) {
    jsmn_parser parser;
    jsmn_init(&parser);
    const char* strin = "{{ALGOTYPE: OLD},{MIN_VAL: 0}}\n";
    const int ntok = 256;
    jsmntok_t tokens[ntok];
    const int res = jsmn_parse(&parser, strin, strlen(strin), tokens, ntok);
    if (0 > res) {
        printf("Error! -> %d\n", res);
        return res;
    }
    for (int i = 0; i < res; ++i) {
        const jsmntok_t token = tokens[i];
        const int toklen = token.end - token.start;
        char buffer[toklen + 1];
        //buffer[0] = '\0';
        snprintf(buffer, toklen + 1, "%s", &(strin[token.start]));
        printf("[%s]::%s\n", JSMNTypeToString(token.type), buffer);

        const int parent = token.parent;
        printf("parent: %d\n", parent);
    }

    return 0;
}
