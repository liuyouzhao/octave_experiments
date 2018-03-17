import os as os

i = 0;
for (root, dirs, files) in os.walk("./test-dnn"):
    for filename in files:
        print os.path.join(root, filename)
        os.system('mv ' + root + '/' + filename + ' ' + root + '/_' + str(i) + '.png');
        i = i + 1;
