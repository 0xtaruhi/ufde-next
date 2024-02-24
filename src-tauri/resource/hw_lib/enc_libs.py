import glob
import os

fdzip = r'fdzip.exe'

for xml_file in glob.glob('*.xml'):
	db_file = xml_file[:-4] + '.db'
	cmd = "%s -z %s -o %s" % (fdzip, xml_file, db_file)
	print(cmd)
	os.system(cmd)
