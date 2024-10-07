/**
 *此Table.class用于测试，，程序的表我放在Monneymanager.class中。。。 
 
 *
 */

import   javax.swing.table.AbstractTableModel;   
  import   javax.swing.*;   
  import   java.awt.GridLayout;   
  import   java.awt.Dimension; 
    
     class   Table   extends   JPanel   { 
	  
	
	  
          /**
		 * 
		 */
		private static final long serialVersionUID = 1L;

		public   Table()   {   
                  JTable   table   =   new   JTable(new   MyTableModel()); 
                  
                  table.setModel(new MyTableModel()); 

                  table.updateUI(); 

                 
                  JScrollPane   scrollPane   =   new   JScrollPane(table);   
                  scrollPane.setPreferredSize(new   Dimension(800, 40));
                  setLayout(new   GridLayout(1,   0));     
                  add(scrollPane);  
          }
                  
                  }
                                  
    
    
          class   MyTableModel   extends   AbstractTableModel   { 
        	  
        	       
 

                  /**
			 * 
			 */
			private static final long serialVersionUID = 1L;
				final   String[]   columnNames   =   {"序号","收入",  "支出", "时间", "备注"};   
                    final static String[][]   data   =   { {},{},{}}  ;
                  
                  
                	   
                	  
                  
                  
                                                       
                  public   int   getColumnCount()   {   
                          //return   columnNames.length;  
                          return 5;
                  }   
    
                  public   int   getRowCount()   {   
                         return   data.length; 
                          //return  100;
                        
                  }   
    
                  public   String   getColumnName(int   col)   {   
                          return   columnNames[col];   
                  }   
    
                  public   Object   getValueAt(int   row,   int   col)   {  
                	  
                	  
                     // return   data[row][col]; 
                	  
                 return   ""+row+","+col;   
             }   
             
  
          
          public   static   void   main(String[]   args)   {   
                  
        	 new Table();
        	
          }   
  }
