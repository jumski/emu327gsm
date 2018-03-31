require 'obd'
require 'pry'
require 'json'


puts 'connecting...'

@obd = OBD.connect '/dev/ttyUSB0'
puts "connected: #{@obd.inspect}"

commands = OBD::Command.pids

# libary-supported commands:
# pids_supported_1
# monitor_status_since_clear
# freeze_dtc
# fuel_system_status
# calculated_engine_load
# engine_coolent_temperature
# short_term_fuel_trim_bank_1
# long_term_fuel_trim_bank_1
# short_term_fuel_trim_bank_2
# long_term_fuel_trim_bank_2
# fuel_pressure
# intake_manifold_absolute_pressure
# engine_rpm
# vehicle_speed
# timing_advance
# intake_air_temperature
# maf_air_flow_rate
# throttle_position
# commanded_secondary_air_status
# oxygen_sensors_present
# bank_1_sensor_1_oxygen_sensor_voltage
# bank_1_sensor_2_oxygen_sensor_voltage
# bank_1_sensor_3_oxygen_sensor_voltage
# bank_1_sensor_4_oxygen_sensor_voltage
# bank_2_sensor_1_oxygen_sensor_voltage
# bank_2_sensor_2_oxygen_sensor_voltage
# bank_2_sensor_3_oxygen_sensor_voltage
# bank_2_sensor_4_oxygen_sensor_voltage
# obd_standards_vehicle_conforms_to
# oxygen_sensors_present_2
# aux_input_status
# run_time_since_engine_start
# pids_supported_2
# distance_traveled_with_mil_on
#
# emulator-supported sensors:
# CoolantTemp
# rpm
# vspeed
# IATSensor
# MAFSensor
# AmbientAirTemp
# CAT1Temp
# CAT2Temp
# CAT3Temp
# CAT4Temp

supported_commands = [
  :engine_coolent_temperature,
  :engine_rpm,
  :vehicle_speed,

]

def fetch_all
  commands = OBD::Command.pids.keys

  @values = commands.reduce({}) do |hash, command|
    print "fetching #{command}..."
    hash[command] = @obd[command]
    puts " = #{hash[command]}"
    hash
  end
end

def save_to_json
  File.open('values.json', 'w') { |f| f.write(JSON.dump(@values)) }
end

fetch_all
# save_to_json

# binding.pry
puts 'aaaa'
