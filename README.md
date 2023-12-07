# I2C : Inter-Integrated Circuit
- An Inter-Integrated Circuit is a Serial Communication Protocol.
- I2C Features: Intra System, Low Speed, Short Distance, Low Band Width (100 : 1000) kbps.
- It support multi master multi slave.
- `Master`: Initiate the communication and generate control signals.
- `Slave`: Respond to the master.
- Two wire communication : `SDA` : Serial data line.  `SCL` : Serial clock line.

## Frame Format
![I2C_Basic_Address_and_Data_Frames](https://github.com/Kholoud-Ebrahim/I2C_Master/assets/108447715/a14e2348-032e-4848-9b9a-6234f91953f9)

### Start:
`SDA` (high to low, negative edge) && `SCL` (high, stable)

### Stop:
`SDA` (low to high, positive edge) && `SCL` (high, stable)
