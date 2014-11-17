execute = (automaton, initialProps) ->
  
  #
  # helper functions for searching inside automaton
  #

  # finds a next state
  getNextState = (sensors) ->
    if automaton[currentState]["successors"].length < 1
      alert "The current state has no successors"
      return false
    for successorState in automaton[currentState]["successors"]
      isValidSuccessorState = true
      # check sensors
      for sensorName, isActive of sensors
        if not automaton[successorState]["props"]["sensors"].hasOwnProperty sensorName
          isValidSuccessorState = false
          break
        else if not automaton[successorState]["props"]["sensors"][sensorName] == isActive
          isValidSuccessorState = false
          break
      # end for
      if isValidSuccessorState
        return successorState
    # end for
    alert "None of the current state's successors can be reached with those sensor readings"
    return false

  # finds an initial state
  getInitialState = (props) ->
    for stateName, state of automaton
      isValidInitialState = true
      # check sensors
      for sensorName, isActive of props.sensors
        if not state["props"]["sensors"].hasOwnProperty sensorName
          isValidInitialState = false
          break
        else if not state["props"]["sensors"][sensorName] == isActive
          isValidSuccessorState = false
          break
      # end for
      if not isValidInitialState
        break
      # check actuators
      for actuatorName, isActive of props.actuators
        if not state["props"]["actuators"].hasOwnProperty actuatorName
          isValidInitialState = false
          break
        else if not state["props"]["actuators"][actuatorName] == isActive
          isValidSuccessorState = false
          break
      # end for
      if not isValidInitialState
        break
      # check customprops
      for custompropName, isActive of props.customprops
        if not state["props"]["customprops"].hasOwnProperty custompropName
          isValidInitialState = false
          break
        else if not state["props"]["customprops"][custompropName] == isActive
          isValidSuccessorState = false
          break
      # end for
      if isValidInitialState
        return stateName
    # end for
    alert "The current configuration of props does not match any possible state in the automaton"
    return false


  # run the execution loop!
  currentState = getInitialState(initialProps)
  until currentState == false
    currentState = getNextState(getSensors())
    console.log(currentState)


exports = {
  execute: execute
}