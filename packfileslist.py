import os

def get_files(directory, base_directory):
    file_list = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            full_path = os.path.join(root, file)
            relative_path = os.path.relpath(full_path, base_directory)
            file_list.append((full_path, relative_path))
    return file_list

def write_to_file(file_list, output_file):
    with open(output_file, 'w') as f:
        for full_path, relative_path in file_list:
            f.write(f"{full_path}\n{relative_path}\n")

def main():
    directory = './packfiles'
    base_directory = os.path.abspath(directory)
    output_file = 'file_list.txt'
    file_list = get_files(directory, base_directory)
    write_to_file(file_list, output_file)

if __name__ == "__main__":
    main()