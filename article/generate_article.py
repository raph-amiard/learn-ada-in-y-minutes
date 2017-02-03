#!/usr/bin/python

import sys
import getopt
import glob
import os

START_EXCLUSION_TAG = '--  Exclude from article'
STOP_EXCLUSION_TAG = '--  End of exclusion'
SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))

def insert_header(out):
    f = open(os.path.join(SCRIPT_DIR, "header.markdown"), "r")
    for line in f:
        out.write(line)
    f.close()

def source_files(dir):
    """Return the list of Ada source files sorted by chapter and spec before
    body"""
    def key(x):
        # Take chapter number for file name
        chapter = int(x[-5:-4])

        # Take ad'b' or ad's' file extension
        body = x[-1:]

        # Lower keys are first in the list so we want spec of chapter 0 to have
        # the lowest key and body of chapter 6 to have the highest key
        return int(chapter) * 10  + (1 if body == "b" else 0)


    # Get list of Ada source files
    files = glob.glob(os.path.join(dir, "*.ad[bs]"))

    # Return list sorted with custom key
    return sorted(files, key=key)

def insert_filtered_source(out, filename):
    include = True
    line_count = 0
    f = open(filename, "r")

    for line in f:
        line_count = line_count + 1
        if START_EXCLUSION_TAG in line:
            if not include:
                print "Nested exclusion tag at %s:%d" % (filename, line_count)
                sys.exit(1)
            else:
                include = False
        elif STOP_EXCLUSION_TAG in line:
            if include:
                print "Unmatched exclusion tag at %s:%d" % (filename, line_count)
                sys.exit(1)
            else:
                include = True
        else:
            if include:
                out.write(line)

    if not include:
        print "missing end of exclusion tag in '%s'" % filename
        sys.exit(1)

    f.close()

def main(argv):
    outputfile = None
    out = None
    try:
        opts, args = getopt.getopt(argv,"ho:",["output="])
    except getopt.GetoptError:
        print 'generate_article.py -o <outputfile>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'generate_article.py -o <outputfile>'
            sys.exit()
        elif opt in ("-o", "--ofile"):
            outputfile = arg

    if outputfile is not None:
        print 'Output file is "%s"' % outputfile
        out = open(outputfile, "w")
    else:
        out = sys.stdout

    insert_header (out)

    # Open code fencing
    out.write("```ada\n")

    sources = source_files(os.path.join(SCRIPT_DIR, "../src"))

    for f in sources:
        insert_filtered_source(out, f)

    # Close code fencing
    out.write("```\n")

    out.close()

if __name__ == "__main__":
    main(sys.argv[1:])
