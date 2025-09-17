#!/usr/bin/expect

set timeout 30  ;# Increase timeout value
set retry_interval 10  ;# Reduced retry interval

# Function to get the current timestamp
proc timestamp {} {
    set now [clock seconds]
    set date [clock format $now -format "%Y-%m-%d %H:%M:%S"]
    return $date
}

# Function to run after successful registration
# proc run_after_successful_registration {} {
#     # This function contains the command to run after successful registration.
#     spawn pm2 restart miner_26
#     expect "Process successfully started"
#     exit 128
# }

# Function for registration
proc registration {} {
    catch {
        spawn btcli subnet register --wallet.name <> --wallet.hotkey <> --netuid 43

        puts "[timestamp] Attempting registration..."

        expect "Do you want to continue" {
            send "y\r"
            expect ""
        }
        
        expect "Enter your password" {
            send "Graphite12345!@#$%\r"
            expect ""
        }

        expect {
            -re ".*Insufficient balance.*" {
                puts "[timestamp] Error encountered: Insufficient balance. Will retry..."
                return
            }
            -re ".*TooManyRegistrationsThisInterval.*|.*❌ Failed.*" {
                puts "[timestamp] Error encountered: TooManyRegistrationsThisInterval or ❌ Failed. Will retry..."
                return
            }
            -re ".*NotEnoughBalanceToStake.*|.*❌ Failed.*" {
                puts "[timestamp] Error encountered: NotEnoughBalanceToStake or ❌ Failed. Will retry..."
                return
            }
            -re ".*RegistrationDisabled.*|.*❌ Failed.*" {
                puts "[timestamp] Error encountered: RegistrationDisabled or ❌ Failed. Will retry..."
                return
            }
            -re ".*Registered.*" {
                puts "[timestamp] Registration completed successfully."
                exit 128
            }
            -timeout 180 {
                puts "[timestamp] Timeout: Unexpected situation. Will retry..."
                return
            }
            eof {
                puts "[timestamp] Unexpected end of file. Will retry..."
                return
            }
            default {
                puts "[timestamp] Unexpected output. Will retry..."
                return
            }
        }

    }
}

# Run the registration function in a loop
while {1} {
    registration
    puts "[timestamp] Waiting $retry_interval seconds before next attempt..."
    sleep $retry_interval
}
