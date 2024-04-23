#include <stdio.h>
#include <windows.h>
#include <stdlib.h>
#include <time.h>

#define ALPHABET_POWER 14
#define ARRAY_SIZE 42

void setConsoleOutputUTF8();

void sortArray(const int array[], int sortedArray[]);

void createIntervalMap(const int sortedArray[], char intervalMap[]);

void mapValuesToChars(const int array[], const char intervalMap[], char chars[]);

void generateMatrix(char chars[], char matrix[][ALPHABET_POWER]);

int getCount(const char *chars, char from, char to);

void generateRandomIntArray(int array[], int size);

char alphabet[] = {'A', 'B', 'C', 'D', 'E', 'F', 'G',
                   'H','I', 'J', 'K', 'L', 'M', 'N',
                   'O', 'P', 'Q', 'R', 'S', 'T',
                   'U', 'V', 'W', 'X', 'Y', 'Z'};

int main() {
    setConsoleOutputUTF8();
    
    int array[ARRAY_SIZE] = {9, 1, 6, 7, 3, 4, 5, 10, 11, 12};

    // comment it out if you want randim array generation
    // generateRandomIntArray(array, 42);

    int sortedArray[ARRAY_SIZE];
    char intervalMap[ARRAY_SIZE];
    char chars[ARRAY_SIZE];
    char matrix[ALPHABET_POWER][ALPHABET_POWER];

    sortArray(array, sortedArray);
    createIntervalMap(sortedArray, intervalMap);
    mapValuesToChars(array, intervalMap, chars);

    printf("Результуючий лінгвістичний ряд: ");
    for (int i = 0; i < ARRAY_SIZE; i++) {
        printf("%c ", chars[i]);
    }
    printf("\n");

    printf("Матриця передування: \n");
    generateMatrix(chars, matrix);

    return 0;
}

void setConsoleOutputUTF8() {
    SetConsoleOutputCP(CP_UTF8);
}

void generateRandomIntArray(int array[], int size) {
    srand(time(NULL)); // Seed the random number generator with the current time

    for (int i = 0; i < size; i++) {
        array[i] = rand() % 50;
    }
}

void sortArray(const int array[], int sortedArray[]) {
    for (int i = 0; i < ARRAY_SIZE; i++) {
        sortedArray[i] = array[i];
    }
    for (int i = 0; i < ARRAY_SIZE - 1; i++) {
        for (int j = i + 1; j < ARRAY_SIZE; j++) {
            if (sortedArray[i] > sortedArray[j]) {
                int temp = sortedArray[i];
                sortedArray[i] = sortedArray[j];
                sortedArray[j] = temp;
            }
        }
    }
}

void createIntervalMap(const int sortedArray[], char intervalMap[]) {
    int intervalSize = ARRAY_SIZE / ALPHABET_POWER;
    char currentInterval = 'A';

    for (int i = 0; i < ARRAY_SIZE; i += intervalSize) {
        for (int j = i; j < (i + intervalSize > ARRAY_SIZE ? ARRAY_SIZE : i + intervalSize); j++) {
            intervalMap[sortedArray[j]] = currentInterval;
        }
        currentInterval++;
    }
}

void mapValuesToChars(const int array[], const char intervalMap[], char chars[]) {
    for (int i = 0; i < ARRAY_SIZE; i++) {
        chars[i] = intervalMap[array[i]];
    }
}

void generateMatrix(char chars[], char matrix[][ALPHABET_POWER]) {
    for (int i = 0; i < ALPHABET_POWER; i++) {
        for (int j = 0; j < ALPHABET_POWER; j++) {
            char from = alphabet[i];
            char to = alphabet[j];
            int count = getCount(chars, from, to);
            matrix[i][j] = '0' + count;
        }
    }

    printf("  ");
    for (int i = 0; i < ALPHABET_POWER; i++) {
        printf("%c ", alphabet[i]);
    }
    printf("\n");

    for (int i = 0; i < ALPHABET_POWER; i++) {
        printf("%c ", alphabet[i]);
        for (int j = 0; j < ALPHABET_POWER; j++) {
            printf("%c ", matrix[i][j]);
        }
        printf("\n");
    }
}

int getCount(const char *chars, char from, char to) {
    int count = 0;
    for (int i = 0; i < ARRAY_SIZE - 1; i++) {
        if (chars[i] == from && chars[i + 1] == to) {
            count++;
        }
    }
    return count;
}

