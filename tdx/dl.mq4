//+------------------------------------------------------------------+
//|                                                           dt.mq4 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---
   openAllCharts();
   //Sleep(1000 * 60 * 5);
   //closeAllCharts();
   
  }
  
  
  void openAllCharts(){
      //open_charts(PERIOD_M1);
      //open_charts(PERIOD_M5);
      //open_charts(PERIOD_M15);
      //open_charts(PERIOD_M30);
      //open_charts(PERIOD_H1);
      
      open_charts(PERIOD_H4);
      open_charts(PERIOD_D1);
      
      open_charts(PERIOD_W1);
      
      open_charts(PERIOD_MN1);
  }
  
  void closeAllCharts(){
  long first = ChartFirst();
   //string name = ChartSymbol(first);
   long next = first;
   while(next != -1){
      next = ChartNext(first);
      bool ret = ChartClose(first);
      first = next;
   }
  
  }
  void open_charts(int period)
{
   int num = SymbolsTotal( false );
   //string symbolList = "Signal List:"
   bool has = false;
   
   int sdindex = 0;
   long pre_chart_id, chart_id = -1;
   for ( int i = 1; i <= num; i++ )
   {
      string name = SymbolName( i - 1, false );
      pre_chart_id = chart_id;
      chart_id = ChartOpen(name, period);
      Sleep(1000 * 2);
      ChartClose(pre_chart_id);
   }
   Sleep(1000 * 2);
   ChartClose(pre_chart_id);
}
//+------------------------------------------------------------------+


