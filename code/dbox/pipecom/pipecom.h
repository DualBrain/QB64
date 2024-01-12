const char* pipecom (char* cmd){
string data;
FILE * stream;
const int max_buffer = 256;
char buffer[max_buffer];

    stream = popen(cmd, "r");
    if (stream) {
        while (!feof(stream)) {
            if (fgets(buffer, max_buffer, stream) != NULL) {
                data.append(buffer);
            }
        }
        pclose(stream);
    }
	//
	//cout << data;
	const char* dataout;
	dataout = strdup(data.c_str());
	return dataout;
}