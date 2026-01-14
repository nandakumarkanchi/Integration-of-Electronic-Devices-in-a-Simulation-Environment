function sysCall_init()
    -- Open the serial connection to the Arduino
    portName = "COM6" -- Replace with the correct port name
    baudRate = 9600

    arduino = sim.serialOpen(portName, baudRate)

    objectHandle = sim.getObject("./Prismatic_joint")

    if arduino == -1 then
        sim.addStatusbarMessage("Failed to open serial connection to Arduino.")
    else
        sim.addStatusbarMessage("Serial connection to Arduino established.")
    end

    graph = sim.getObject("/Graph")
    Plot = sim.addGraphStream(graph, "Weight", "g", 0, {1, 0, 0})
end


function sysCall_actuation()
    -- Read data from Arduino
    data = sim.serialRead(arduino, 1000, true, '\n', 10)
    data1 = tonumber(data)

    print(data1)

    if data1 ~= nil then
        sim.setJointTargetPosition(objectHandle, data1 * 0.00015)
        print(data1 * 0.001)
    end
end


function sysCall_sensing()
    sim.setGraphStreamValue(graph, Plot, data1)
end


function sysCall_cleanup()
    -- Close the serial connection to the Arduino
    sim.serialClose(arduino)
    sim.addStatusbarMessage("Serial connection to Arduino closed.")
end
