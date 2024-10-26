import wave
import numpy as np

""" 

expects some text in the format:

1C3A9C8E
826FFF21
FFFAABC3
.
.
.

"""
with open("data.txt", "r") as file:
    i2s_data = [int(line.strip(), 16) for line in file.readlines()]

samples = np.array([(sample >> 8) & 0xFFFFFF for sample in i2s_data], dtype=np.int32) #shifted 8 since we dont do that on the hardware level

sample_bytes = bytearray()

for sample in samples:
    sample = int(sample)
    if sample & 0x800000: #preventing overflow, converts unsigned to signed
        sample -= 0x1000000  
    sample_bytes += sample.to_bytes(3, byteorder="little", signed=True) #check again on the little endian thing might be wrong

with wave.open("speech.wav", "wb") as wav_file:
    wav_file.setnchannels(1) #mono
    wav_file.setsampwidth(3) # 3 bytes since its 24 bits
    wav_file.setframerate(125000) #dk if this is right, i did the math based on it being mono
    wav_file.writeframes(sample_bytes) #the data given