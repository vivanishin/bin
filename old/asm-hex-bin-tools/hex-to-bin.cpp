#include <iostream>
#include <fstream>
#include <string>
using namespace std;

int main(int argc, char* argv[]) {
    if (argc < 2) {
        cout << "please provide the input file containing ascii-encoded"
            " hex string" << endl;
        return 1;
    }

    string str;
    ifstream input_stream(argv[1]);
    input_stream >> str;

    int len = str.length();
    if (len % 2 != 0) {
        cout << "str len must be even" << endl;
        return 1;
    }

    char* buffer = new char[len / 2];
    for (auto i = 0; i < len; i += 2) {
        buffer[i / 2] = strtoul(str.substr(i, 2).data(), nullptr, 16);
    }

    string input_file_name(argv[1]);
    ofstream output_file (input_file_name + ".bin", ios::out | ios::binary);
    output_file.write (buffer, len / 2);
    output_file.close();

    delete[] buffer;
    return 0;
}
