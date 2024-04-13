#!/bin/bash

source setup_lib.sh
# Function to create a Flutter app
create_flutter_app() {
  local app_name="$1"
  shift  # Shift app_name argument
  local dependencies=("$@")

  flutter create "$app_name"

  if [ "${#dependencies[@]}" -gt 0 ]; then
    cd "$app_name"
    add_dependencies "${dependencies[@]}"
    cd ..
  fi
  cd "$app_name"
  setup_lib "$app_name"

  echo "Flutter app '$app_name' created with specified dependencies."
  cd ..
  open_vscode "$app_name"
}

# Function to create an Appwrite function
create_appwrite_function() {
  local function_name="$1"

    # Check if appwrite.json file exists in the current directory
    if [ -f "appwrite.json" ]; then
        # Add your logic here to create the Appwrite function
        echo "Creating Appwrite function '$function_name'..."
            appwrite init function <<EOF
          $function_name
          
EOF



    else
      echo "Initialising project"
    appwrite init project


    fi
}

# Function to add dependencies to pubspec.yaml
add_dependencies() {
  while [ "$#" -gt 0 ]; do
    local dependency="$1"
    echo "Adding dependency: $dependency"
    flutter pub add "$dependency"
    shift
  done
}

# Function to create folders and files in lib directory


# Function to open Visual Studio Code
open_vscode() {
  local app_name="$1"
  code "$app_name"
}

# Main function to handle command line arguments
main() {
  case "$1" in
    create)
      shift
      case "$1" in
        --app)
          shift
          create_flutter_app "$@"
          ;;
        --function)
          shift
          create_appwrite_function "$@"
          ;;
        *)
          echo "Unknown command: $1"
          ;;
      esac
      ;;
    *)
      echo "Unknown command: $1"
      ;;
  esac
}

# Check if flutter command is available
if ! command -v flutter &> /dev/null; then
  echo "Flutter SDK is not installed or not in PATH. Please install Flutter."
  exit 1
fi

# Check if VSCode is installed
if ! command -v code &> /dev/null; then
  echo "Visual Studio Code is not installed or not in PATH. Please install VSCode."
  exit 1
fi

# Check if at least one argument is provided
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <command>"
  echo "Available commands:"
  echo "  create --app <app_name> [dependencies]: Create a Flutter app with optional dependencies."
  echo "  create --function <function_name>: Create an Appwrite function."
  exit 1
fi

# Call the main function with provided arguments
main "$@"
