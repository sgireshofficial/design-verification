import pandas as pd
import subprocess

def run_sv_test(index,test_name,seed_number):
   command=["vcs","-R","-full64","-sverilog","-kdb","-debug_access+all",
         "-override_timescale=1ns/1ns","../rtl/apb_slave_design.sv",
         "../env/interface.sv","../test/package.sv","../top/top.sv",
         "+incdir+/home/dvft0904/apb_sv_project/test/ +incdir+/home/dvft0904/apb_sv_project/env/ +incdir+/home/dvft0904/apb_sv_project/top/",
         "+{}".format(test_name),"+seed={}".format(seed_number),
         "-cm","line+cond+fsm+tgl+branch+assert","-cm_dir",
         "{}_coverage.vdb".format(test_name),"-l","{}.log".format(test_name)]

   command1=["vcs","-R","-full64","-sverilog","-kdb","-debug_access+all",
         "-override_timescale=1ns/1ns","../rtl/apb_slave_design.sv",
         "../env/interface.sv","../test/package.sv","../top/top.sv",
         "+incdir+/home/dvft0904/apb_sv_project/test/ +incdir+/home/dvft0904/apb_sv_project/env/ +incdir+/home/dvft0904/apb_sv_project/top/",
         "+{}".format(test_name),"+seed={}".format(seed_number),"+zerowaitstate",
         "-cm","line+cond+fsm+tgl+branch+assert","-cm_dir",
         "{}_coverage.vdb".format(test_name),"-l","{}.log".format(test_name)]


   if(index<5):
      print("Executing command: {}",format(' '.join(command)))
      result=subprocess.run(command,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
   else:
      print("Executing command: {}",format(' '.join(command1)))
      result=subprocess.run(command1,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
      

   print("STDOUT:",result.stdout.decode())
   print("STDERR:",result.stderr.decode())
   if(result.returncode==0):
      print("Test {} completed successfully.".format(test_name))
   else:
      print("Test {} failed with error:\n{}".format(test_name,stderr.decode()))

def main():
   print("Started the regresion process")
   ods_file='/home/dvft0904/apb_sv_project/sim/test.ods'
   try:
      df=pd.read_excel(ods_file,engine='odf')
      print("Loaded data from {}".format(ods_file))
      if(df.empty):
         print("The dataframe is empty please check your ods file")
         return
      print("Dataframe contents:\n",df)
   except Exception as e:
      print("Error, loading ODS file:{}".format(e))
      return

   for index,row in df.iterrows():
      serial_no,test_name,run_flag,seed_number=row
      print("processing row:{},Test name: {}, Run Flag: {}".format(index,test_name,run_flag))
      if(run_flag==1):
         run_sv_test(index,test_name,seed_number)
      else:
         print("Skipping test:{}(Run Flag: {})".format(test_name,run_flag))


if __name__=="__main__":
   main()

   

   
