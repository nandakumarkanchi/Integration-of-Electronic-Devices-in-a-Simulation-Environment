#include "HX711.h"

#define calibration_factor 400   // setting calibration factor to 400
#define LOADCELL_DOUT_PIN 3       // define PIN 3 as data output
#define LOADCELL_SCK_PIN 2        // define PIN 2 as clock

HX711 scale;

void setup() {
    Serial.begin(9600);           // establish serial communication
    Serial.println("HX711 scale demo");

    scale.begin(LOADCELL_DOUT_PIN, LOADCELL_SCK_PIN);
    scale.set_scale(calibration_factor);
    scale.tare();                // reset the scale to 0

    Serial.println("Readings:");
}

void loop() {
    Serial.print("Reading: ");
    Serial.print(scale.get_units(), 1); // print values in grams
    Serial.print(" g");
    Serial.println();

    delay(500); // small delay for stable readings
}
