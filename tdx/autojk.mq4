//+------------------------------------------------------------------+
//|                                                      CCTimeX.mq4 |
//|                                       Copyright 漏 2015, Barmaley |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright ""
#property link      ""
//---
#property indicator_chart_window
//---
int ts=12;
int PP;
int X0;
int Y0;
//---
string PPS;
int TFCount=0;
int TFSX[50];
//---
int ServerTimeOffset=0;// 小屑械褖械薪懈械 胁褉械屑械薪懈 褋械褉胁械褉邪 芯褌薪芯褋懈褌械谢褜薪芯 谢芯泻邪谢褜薪芯谐芯 胁褉械屑械薪懈 泻芯屑锌褜褞褌械褉邪
extern string TFS="  1 5 15 20 30 60 240 480 1440 ";
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

int chk_fg[200];
string trend_list[200];
int idx = 0;



int OnInit()
  {
   //check_data_status(1, "SUGAR", PERIOD_H4);
   /*
   string jk_list[] = {
      "UK100_M5_H4"
   };
   
   jk_list_scanner(jk_list);
   */
   //get_current_times(PERIOD_M1);
   //get_last_bar_times(PERIOD_H4);
   //get_trend_counts("L");
   
   string list = "";
   get_trends_list(list, "L");
   Print(list);
   
   //print_symbol_list();
   //string list = "";
   
   //get_signs(list, true, false, 1);
   get_signs(list, true, true, 0);
   //open_manul_list();
   
   //open_charts(PERIOD_H4);
   //open_charts(PERIOD_D1);
   //open_charts(PERIOD_W1);
   //open_charts(PERIOD_MN1);
  
  
   //---
   string s="ServerTime";
   //---
   ObjectCreate(s,OBJ_LABEL,0,0,0,0,0,0,0);
   ObjectSetText(s,"");
   X0=ChartGetInteger(0,CHART_WIDTH_IN_PIXELS)/2;
   Y0=ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS)/9;
   ObjectSet(s,OBJPROP_XDISTANCE,X0);
   ObjectSet(s,OBJPROP_YDISTANCE,Y0);
   //---
   s="";
   int i=0;
   int n=StringLen(TFS);
   //--- 校写邪谢械薪懈械 谢懈褕薪懈褏 褋懈屑胁芯谢芯胁 懈蟹 褋锌懈褋泻邪 褌邪泄屑褎褉械泄屑芯胁, 芯褋褌邪褞褌褋褟 褌芯谢褜泻芯 褑懈褎褉褘 懈 锌褉芯斜械谢褘
   for(i=0;i<=n-1;i++)
     {
      int k=StringGetCharacter(TFS,i);
      string ss=StringSubstr(TFS,i,1);
      if(ss==" " || (k>=48 && k<=57)) s=s+ss;
     }
   //---
   TFS=s+" "; s="";
   //--- 袨斜褉邪斜芯褌泻邪 褋锌懈褋泻邪 褌邪泄屑褎褉械泄屑芯胁    
   while(true)
     {
      i=StringFind(TFS," ");
      if(i<0) break;
      //---
      n=StringLen(TFS);
      if(i==0) TFS=StringSubstr(TFS,1,n-1);
      else
        {
         ss=StringSubstr(TFS,0,i+1);
         k=(int)ss;
         if(k<=1440)
            if((k<=60 && MathMod(60,k)==0) || (k>60 && MathMod(1440,k)==0))// 袩褉芯胁械褉泻邪 孝肖 薪邪 泻芯褉褉械泻褌薪芯褋褌褜
              {
               TFSX[TFCount]=(int)ss;
               TFCount++;
              }
         //---
         TFS=StringSubstr(TFS,i,1000);
        }
     }
   //---
   if(TFCount==0) {TFCount++; TFSX[0]=_Period;} // 袩褍褋褌芯泄 褋锌懈褋芯泻 = 褌械泻褍褖懈泄 褌邪泄屑褎褉械泄屑
   //---
   for(i=0;i<=TFCount-1;i++)
     {
      s="ServerTime"+(string)i;
      ObjectCreate(s,OBJ_LABEL,0,0,0,0,0,0,0);
      ObjectSetText(s,"");
      s="ServerTime"+(string)i+(string)i;
      ObjectCreate(s,OBJ_LABEL,0,0,0,0,0,0,0);
      ObjectSetText(s,"");
     }
   //---
   EventSetTimer(1);
   //print_symbol_list();
   return(INIT_SUCCEEDED);
}


string mfl_l[] = {
      //"AUDCAD",
      //"AUDCHF",
      //"AUDCNH",
      //"AUDJPY",
      //"AUDNOK",
      //"AUDNZD",
      //"AUDPLN",
      //"AUDSGD",
      //"AUDUSD",
      //"AUS200",
      //"CADCHF",
      //"CADJPY",
      //"CADNOK",
      //"CADPLN",
      //"CHFHUF",
      //"CHFJPY",
      //"CHFNOK",
      //"CHFPLN",
      "CHINAA50",
      //"CNHJPY",
      //"COPPER",
      //"CORN",
      //"COTTON",
      //"ESP35",
      //"ESTX50",
      //"EURAUD",
      //"EURCAD",
      "EURCHF",
      "EURCNH",
      //"EURCZK",
      //"EURDKK",
      "EURGBP",
      "EURHKD",
      //"EURHUF",
      "EURJPY",
      //"EURMXN",
      //"EURNOK",
      //"EURNZD",
      //"EURPLN",
      //"EURRON",
      "EURRUB",
      //"EURSEK",
      "EURSGD",
      //"EURTRY",
      "EURUSD",
      //"EURZAR",
      //"FRA40",
      //"GBPAUD",
      //"GBPCAD",
      //"GBPCHF",
      //"GBPDKK",
      "GBPHKD",
      //"GBPJPY",
      //"GBPMXN",
      //"GBPNOK",
      //"GBPNZD",
      //"GBPPLN",
      //"GBPSEK",
      //"GBPSGD",
      "GBPUSD",
      //"GBPZAR",
      //"GER30",
      //"GOLD",
      //"GOLDFUT",
      //"GOLDMINI",
      //"HK50",
      //"HKDJPY",
      //"HTG_OIL",
      //"IT40",
      //"JPN225",
      //"N25",
      //"NAS100",
      //"NOKDKK",
      "NOKJPY",
      //"NOKSEK",
      //"NZDCAD",
      //"NZDCHF",
      //"NZDJPY",
      //"NZDUSD",
      //"PALLAD",
      //"PLAT",
      "SGDHKD",
      //"SGDJPY",
      //"SIGI",
      //"SILVER",
      //"SILVERFUT",
      //"SILVERMINI",
      //"SOYBEAN",
      //"SPX500",
      //"SUGAR",
      //"SWISS20",
      //"TRYJPY",
      //"UK100",
      //"UK_OIL",
      //"US2000",
      //"US30",
      //"US_NATG",
      //"US_OIL",
      //"USDCAD",
      //"USDCHF",
      //"USDCNH",
      //"USDCZK",
      //"USDDKK",
      //"USDHKD",
      //"USDHUF",
      //"USDILS",
      //"USDJPY",
      //"USDMXN",
      //"USDNOK",
      //"USDPLN",
      //"USDRON",
      //"USDRUB",
      //"USDSEK",
      //"USDSGD",
      //"USDTHB",
      //"USDTRY",
      //"USDX",
      //"USDZAR",
      //"WHEAT",
      //"ZARJPY"
};

   string mfl_s[] = {
   //"AUDCAD",
   //"AUDCHF",
   //"AUDCNH",
   //"AUDJPY",
   //"AUDNOK",
   //"AUDNZD",
   //"AUDPLN",
   //"AUDSGD",
   //"AUDUSD",
   //"AUS200",
   //"CADCHF",
   //"CADJPY",
   //"CADNOK",
   //"CADPLN",
   //"CHFHUF",
   //"CHFJPY",
   //"CHFNOK",
   //"CHFPLN",
   //"CHINAA50",
   //"CNHJPY",
   //"COPPER",
   //"CORN",
   //"COTTON",
   //"ESP35",
   //"ESTX50",
   //"EURAUD",
   //"EURCAD",
   //"EURCHF",
   //"EURCNH",
   //"EURCZK",
   //"EURDKK",
   //"EURGBP",
   //"EURHKD",
   //"EURHUF",
   //"EURJPY",
   //"EURMXN",
   //"EURNOK",
   //"EURNZD",
   //"EURPLN",
   //"EURRON",
   //"EURRUB",
   //"EURSEK",
   //"EURSGD",
   //"EURTRY",
   //"EURUSD",
   //"EURZAR",
   //"FRA40",
   //"GBPAUD",
   //"GBPCAD",
   //"GBPCHF",
   //"GBPDKK",
   //"GBPHKD",
   //"GBPJPY",
   //"GBPMXN",
   //"GBPNOK",
   //"GBPNZD",
   //"GBPPLN",
   //"GBPSEK",
   //"GBPSGD",
   //"GBPUSD",
   //"GBPZAR",
   //"GER30",
   //"GOLD",
   //"GOLDFUT",
   //"GOLDMINI",
   //"HK50",
   //"HKDJPY",
   //"HTG_OIL",
   //"IT40",
   //"JPN225",
   //"N25",
   //"NAS100",
   //"NOKDKK",
   //"NOKJPY",
   //"NOKSEK",
   //"NZDCAD",
   //"NZDCHF",
   //"NZDJPY",
   //"NZDUSD",
   //"PALLAD",
   //"PLAT",
   //"SGDHKD",
   //"SGDJPY",
   //"SIGI",
   //"SILVER",
   //"SILVERFUT",
   //"SILVERMINI",
   //"SOYBEAN",
   //"SPX500",
   //"SUGAR",
   //"SWISS20",
   //"TRYJPY",
   //"UK100",
   //"UK_OIL",
   //"US2000",
   //"US30",
   //"US_NATG",
   //"US_OIL",
   //"USDCAD",
   //"USDCHF",
   //"USDCNH",
   //"USDCZK",
   //"USDDKK",
   //"USDHKD",
   //"USDHUF",
   //"USDILS",
   //"USDJPY",
   //"USDMXN",
   //"USDNOK",
   //"USDPLN",
   //"USDRON",
   //"USDRUB",
   //"USDSEK",
   //"USDSGD",
   //"USDTHB",
   //"USDTRY",
   //"USDX",
   //"USDZAR",
   //"WHEAT",
   //"ZARJPY"
};




int period_values[] = {PERIOD_M1, PERIOD_M5, PERIOD_M15, PERIOD_M30, PERIOD_H1, PERIOD_H4, PERIOD_D1, PERIOD_W1, PERIOD_MN1};
string period_names[] = {"M1", "M5", "M15", "M30", "H1", "H4", "D1", "W1", "MN1"};

string period_value2name(int period){
   string name = "H4";
   for(int i =0; i < ArraySize(period_values); i++){
      if(period == period_values[i]){
         name = period_names[i];
      }
   }
   return name;
}

int period_name2value(string name){
   int period = PERIOD_H4;
   for(int i =0; i < ArraySize(period_names); i++){
      if(name == period_names[i]){
         period = period_values[i];
      }
   }
   return period;
}


void jk_list_scanner(string jk_list[]){

   for(int l = 0; l < ArraySize(jk_list); l++){
      string symbol;

      string sep = "_";                // A separator as a character
      ushort u_sep;                  // The code of the separator character
      string jk_item_cols[];               // An array to get strings
      //--- Get the separator code
      u_sep = StringGetCharacter(sep,0);
      //--- Split the string to substrings
      int k = StringSplit(jk_list[l],u_sep,jk_item_cols);
      //--- Now output all obtained strings
      if(k>1)
      {
         symbol = jk_item_cols[0];
         for(int i = 1; i < k; i++)
         {
            PrintFormat("%s : %s, %d", symbol, jk_item_cols[i], period_name2value(jk_item_cols[i]));
         }
      }
   }

}

datetime get_symbol_get_last_bar_time(string symbol, int period){

   /*
   MqlRates rates[];
   int copied=CopyRates(symbol, period, 0, 100, rates);
   if(copied<=0){
      Print("Error copying price data ",GetLastError());
   }
      else{
         
      }
      */

   PrintFormat("%s - %s / %s", symbol, TimeToStr(SymbolInfoInteger(symbol,SYMBOL_TIME), TIME_DATE|TIME_MINUTES), TimeToStr(TimeLocal(), TIME_DATE|TIME_MINUTES));
}

void get_last_bar_times(int period)
{
   int num = SymbolsTotal( false );
   //string symbolList = "Signal List:"
    bool has = false;
   
      //long chart_id = ChartOpen("UK100", PERIOD_H4);

   int sdindex = 0;
   for ( int i = 1; i <= num; i++ )
   {
      string name = SymbolName( i - 1, false );
      //get_symbol_get_last_bar_time(chart_id, name, period);
      get_symbol_get_last_bar_time(name, period);
   }
}

void get_current_times(int period)
{
   int num = SymbolsTotal( false );
   //string symbolList = "Signal List:"
   bool has = false;
   
   int sdindex = 0;
   for ( int i = 1; i <= num; i++ )
   {
      string name = SymbolName( i - 1, false );
      get_symbol_current_time(name, period);
   }
}

int get_current_bar_left_time(string symbol, int period){
   return get_symbol_current_time(symbol, period) - get_symbol_server_time(symbol);
}

datetime get_symbol_server_time(string symbol){
   return get_symbol_current_time(symbol, PERIOD_M1);
}


datetime get_symbol_current_time(string symbol, int period){

   datetime tm_buf[];
   int num = 100;
   ArrayResize(tm_buf, num);
   ArraySetAsSeries(tm_buf, true);
   
   
   
   int copied = CopyTime(symbol, period, 0, num, tm_buf);
   RefreshRates();
   PrintFormat("%s - %s", symbol, TimeToStr(tm_buf[0], TIME_DATE|TIME_MINUTES));

   return tm_buf[0];
}


void get_history_data(string symbol, int period){
   long handle = ChartOpen(symbol, period);
      if(handle != 0)
    {
      bool res = ChartNavigate(handle, CHART_BEGIN, 0);
      if(!res){
         Print("Navigate failed. Error = ", GetLastError());
      }
      ChartRedraw();
     }
}


string get_manual_follow_list(string direct){
   string list = " MF: ";
   int i = 0;
   if(direct == "L"){
      for(i = 0; i < ArraySize(mfl_l); i++){
         list = list + mfl_l[i]  + " / ";
         trend_list[idx++] = mfl_l[i];
      }  
   }else{
      for(i = 0; i < ArraySize(mfl_s); i++){
         list = list + mfl_s[i]  + " / ";
      } 
   }
   list = list + "\n";
   return list;
}


int check_manual_follow(string symbolname, string direct){
   int sign = 0;

   int i = 0;
   if(direct == "L"){
      for(i = 0; i < ArraySize(mfl_l); i++){
         if(symbolname == mfl_l[i]){
            sign = 1;
            break;
         }
      }
   }else{
      for(i = 0; i < ArraySize(mfl_s); i++){
         if(symbolname == mfl_s[i]){
            sign = 1;
            break;
         }
      }
   }
   
   return sign;
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   string s="ServerTime";
   //---
   if( reason==REASON_CHARTCHANGE || reason==REASON_PARAMETERS) return;
   //---
   ObjectDelete(s);
   //---
   for(int i=0;i<=TFCount-1;i++)
     {
      s="ServerTime"+(string)i+(string)i;
      ObjectDelete(s);
      //---
      s="ServerTime"+(string)i;
      ObjectDelete(s);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   //--- 小屑械褖械薪懈械 胁褉械屑械薪懈 褋械褉胁械褉邪 芯褌薪芯褋懈褌械谢褜薪芯 谢芯泻邪谢褜薪芯谐芯 胁褉械屑械薪懈 泻芯屑锌褜褞褌械褉邪   
   if(MarketInfo(_Symbol,MODE_TRADEALLOWED)>0) ServerTimeOffset=TimeCurrent()-TimeLocal();
   //---
   return(rates_total);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTimer()
  {
   //--- 袩芯谢芯卸械薪懈械 褋懈薪懈褏 褔邪褋芯胁
   int x=ObjectGet("ServerTime",OBJPROP_XDISTANCE);
   int y=ObjectGet("ServerTime",OBJPROP_YDISTANCE);
   ts=ObjectGet("ServerTime",OBJPROP_FONTSIZE);
   //---
   datetime tt=TimeLocal()+ServerTimeOffset;
   //--- 小械褉胁械褉薪芯械 胁褉械屑褟
   ObjectSetText("ServerTime",TimeToStr(tt,TIME_SECONDS),ts,"Courier New",clrRoyalBlue);
   //--- 孝邪泄屑械褉褘 斜邪褉芯胁
   for(int i=0;i<=TFCount-1;i++)
     {
      PP=TFSX[i];
      //---
      PPS="M"+(string)PP;
      if(PP==1440) PPS="D1";
      else if(PP>=60) PPS="H"+(string)(PP/60);
      //---
      //int n=tt/PP/60;
      //datetime it=n*PP*60;
      //datetime t=PP*60-tt+it;
      
      datetime t = get_close_seconds_left(TFSX[i]);
      
      //---
      string s="ServerTime"+(string)i+(string)i;
      ObjectSetText(s,TimeToStr(t,TIME_SECONDS),ts,"Courier New",clrRed);
      ObjectSet(s,OBJPROP_XDISTANCE,x);
      ObjectSet(s,OBJPROP_YDISTANCE,y+(ts+5)*(i+1));
      //---
      s="ServerTime"+(string)i;
      ObjectSetText(s,PPS,ts,"Courier New",clrRed);
      ObjectSet(s,OBJPROP_XDISTANCE,x-ts*5);
      ObjectSet(s,OBJPROP_YDISTANCE,y+(ts+5)*(i+1));
     }
  }
  
datetime get_close_seconds_left(int period){
   int PP = period;
   datetime tt=TimeLocal()+ServerTimeOffset;
   int n=tt/PP/60;
   datetime it=n*PP*60;
   datetime t=PP*60-tt+it;
   check_actions(period, (int)t);
   return t;
}

bool isCheckSignal(int period){
   bool check = false;
   
   if(period == PERIOD_H4){
      check = true;
   }
   
   return check;
}


bool isCheckTrend(int period){
   bool check = false;
   
   if(period == PERIOD_D1){
      check = true;
   }
   
   return check;
}

bool isDataReady(int leftseconds){
   bool ready = false;
   
   if(leftseconds == 3){
      ready = true;
   }
   
   return ready;
}

void check_actions(int period, int leftseconds){
   string symbolList = "";
   //if(isCheckSignal(period) && isDataReady(leftseconds)){
   if(isCheckSignal(period)){
      symbolList = "IFX:Signal list:";
      if(get_signs(symbolList, false, false, 0)){
         SendMail("Signal" + symbolList, symbolList);
         Print(symbolList);
      }
      
   }
   
   if(isCheckTrend(period) && isDataReady(leftseconds)){
      symbolList = "IFX:Trend list:" + "\n";
      get_trends_list(symbolList, "L");
      SendMail("Trend" + symbolList, symbolList);
      Print(symbolList);
   }
}

void print_symbol_list(){
   int num = SymbolsTotal( false );

   for ( int i = 1; i <= num; i++ )
   {
      string name = SymbolName( i - 1, false );
      Print(i + " : " + name);
   }
}

void get_trends_list(string& symbolList, string direct){
   idx = 0;
   symbolList = symbolList + get_manual_follow_list(direct);
   symbolList = symbolList + get_trend_aqq_list(direct);
   symbolList = symbolList + get_trend_count_list(direct);
   symbolList = symbolList + get_trend_zx_list(direct);
}


void get_trend_counts(string direct){
   int num = SymbolsTotal( false );
   //string symbolList = "Trend list:";

   for ( int i = 1; i <= num; i++ )
   {
      string name = SymbolName( i - 1, false );

      int tc = get_trend_count(name, PERIOD_W1, direct);
      Print("Trend  " + name + ":" + IntegerToString(tc));
   }
   
}



int get_trend_count(string symbol, int period, string direct){
   int count = 0;
   datetime start_time  = D'1980.01.01 00:00';
   datetime stop_time = TimeCurrent();

   MqlRates rates[];
   ArraySetAsSeries( rates, true );

   RefreshRates();
   int copied = CopyRates( symbol, period, start_time, stop_time, rates );

   if(copied > 2){

      int i = 1;
      for(; i < copied; i++){
         if(direct == "L"){
            if(rates[1].close < rates[i].close){
               break;
            }
         }else{
            if(rates[1].close > rates[i].close){
               break;
            }
         }
      }
      count = i;
   }

   return count;
}




bool check_date(datetime last_day){
   return (Year()==TimeYear(last_day) && Month()==TimeMonth(last_day) && Day()==TimeDay(last_day));
}

int get_symbol_period_data(string symbol, int period, int atemptnum){
   datetime daytimes[];
   double opens[];
   double highs[];
   double lows[];
   double closes[];
   long volumes[];
   int error;
   datetime last_day = D'1980.01.01 00:00';
   
   //---- the Time[] array was sroted in the descending order
   int copied = ArrayCopySeries(daytimes,MODE_TIME,symbol,period);
   /*
   copied = ArrayCopySeries(opens,MODE_OPEN,symbol,period);
   copied = ArrayCopySeries(lows,MODE_LOW,symbol,period);
   copied = ArrayCopySeries(highs,MODE_HIGH,symbol,period);
   copied = ArrayCopySeries(closes,MODE_CLOSE,symbol,period);
   copied = ArrayCopySeries(volumes,MODE_VOLUME,symbol,period);
   */
   error=GetLastError();
   if(error==ERR_HISTORY_WILL_UPDATED )
     {
      //---- make two more attempts to read
      for(int i=0;i<atemptnum; i++)
        {
         Sleep(5000);
         copied = ArrayCopySeries(daytimes,MODE_TIME,symbol,period);
         /*
         copied = ArrayCopySeries(opens,MODE_OPEN,symbol,period);
         copied = ArrayCopySeries(lows,MODE_LOW,symbol,period);
         copied = ArrayCopySeries(highs,MODE_HIGH,symbol,period);
         copied = ArrayCopySeries(closes,MODE_CLOSE,symbol,period);
         copied = ArrayCopySeries(volumes,MODE_VOLUME,symbol,period);
         */
         //---- check the current daily bar time
         last_day=daytimes[0];
         if(check_date(last_day)) break;
        }
     }
     
   return copied;
     
   //return check_date(last_day);
}

int check_trend(string symbolname, string direct){
   int sign = 0;
   int tc = get_trend_count(symbolname, PERIOD_W1, direct);
   int aqq = check_trend_aqq(symbolname, direct);
   int mf = check_manual_follow(symbolname, direct);
   if(mf > 0 || tc > 20 || aqq > 0){
      sign = 1;
   }
   return sign;
}

string get_trend_count_list(string direct){
   string list = " XGD: ";

   int num = SymbolsTotal( false );
   //string symbolList = "Trend list:";

   for ( int i = 1; i <= num; i++ )
   {
      string name = SymbolName( i - 1, false );
      if(StringFind(name, "pro", 6) > 0){
         continue;
      }
      int tc = get_trend_count(name, PERIOD_W1, direct);
      if(tc > 20){
         list = list + name + " / ";;
         //trend_list[idx++] = name;
      }
   }
   list = list + "\n";
   return list;
}

string get_trend_aqq_list(string direct){
   string list = " AQQ: ";

   int num = SymbolsTotal( false );
   //string symbolList = "Trend list:";

   for ( int i = 1; i <= num; i++ )
   {
      string name = SymbolName( i - 1, false );

      if(StringFind(name, "pro", 6) > 0){
         continue;
      }
      int aqq = check_trend_aqq(name, direct);
      if(aqq > 0){
         list = list + name + " / ";;
         //trend_list[idx++] = name;
      }
   }
   list = list + "\n";
   return list;
}

string get_trend_zx_list(string direct){
   string list = " ZX: ";

   int num = SymbolsTotal( false );
   //string symbolList = "Trend list:";

   for ( int i = 1; i <= num; i++ )
   {
      string name = SymbolName( i - 1, false );

      if(StringFind(name, "pro", 6) > 0){
         continue;
      }
      int aqq = check_trend_zhuanxiang(name, direct);
      if(aqq > 0){
         list = list + name + " / ";
         //trend_list[idx++] = name;
      }
   }
   list = list + "\n";
   return list;
}

int check_trend_aqq(string symbolname, string direct){
   
   int sign = 0;
   
   double close_H4_buf[];
   double close_D1_buf[];
   double close_W1_buf[];
   double close_MN1_buf[];
   datetime tm_buf[];
   int num = 100;
   ArrayResize(close_H4_buf, num);
   ArrayResize(close_D1_buf, num);
   ArrayResize(close_W1_buf, num);
   ArrayResize(close_MN1_buf, num);
   ArrayResize(tm_buf, num);
   ArraySetAsSeries(close_H4_buf, true);
   ArraySetAsSeries(close_D1_buf, true);
   ArraySetAsSeries(close_W1_buf, true);
   ArraySetAsSeries(close_MN1_buf, true);
   ArraySetAsSeries(tm_buf, true);
   
   
   
   
   int copied = CopyTime(symbolname, PERIOD_D1, 0, num, tm_buf);
   copied = CopyClose(symbolname, PERIOD_H4, 0, num, close_H4_buf);
   copied = CopyClose(symbolname, PERIOD_D1, 0, num, close_D1_buf);
   copied = CopyClose(symbolname, PERIOD_W1, 0, num, close_W1_buf);
   copied = CopyClose(symbolname, PERIOD_MN1, 0, num, close_MN1_buf);
   
   RefreshRates();
   
   double ma_d1_30,
   ma_w1_30,
   ma_mn_30,
   ma_d1_30_pre,
   ma_w1_30_pre,
   ma_mn_30_pre;
   
   get_symbol_period_data(symbolname, PERIOD_D1, 5);
   get_symbol_period_data(symbolname, PERIOD_W1, 5);
   get_symbol_period_data(symbolname, PERIOD_MN1, 5);
   
   
   ma_d1_30 = iMA( symbolname, PERIOD_D1, 30, 0, MODE_SMA, PRICE_CLOSE, 1 );
   ma_w1_30 = iMA( symbolname, PERIOD_W1, 30, 0, MODE_SMA, PRICE_CLOSE, 1 );
   ma_mn_30 = iMA( symbolname, PERIOD_MN1, 30, 0, MODE_SMA, PRICE_CLOSE, 1 );
   
   ma_d1_30_pre   = iMA( symbolname, PERIOD_D1, 30, 0, MODE_SMA, PRICE_CLOSE, 2 );
   ma_w1_30_pre   = iMA( symbolname, PERIOD_W1, 30, 0, MODE_SMA, PRICE_CLOSE, 2 );
   ma_mn_30_pre   = iMA( symbolname, PERIOD_MN1, 30, 0, MODE_SMA, PRICE_CLOSE, 2 );
   
   //PrintFormat("check_trend %s : %f, %f, %f, %f, %f, %f - %s", symbolname, ma_d1_30, ma_w1_30, ma_mn_30, ma_d1_30_pre, ma_w1_30_pre, ma_mn_30_pre, TimeToStr(tm_buf[0], TIME_DATE|TIME_MINUTES));
   
   if(ma_d1_30 > ma_d1_30_pre && ma_w1_30 > ma_w1_30_pre && ma_mn_30 > ma_mn_30_pre){
      sign = 1;
      //PrintFormat("%s", symbolname);
   }
   
   return sign;
}



int check_trend_zhuanxiang(string symbolname, string direct){
   
   int sign = 0;
   
   double open_W1_buf[];
   double close_W1_buf[];
   datetime tm_buf[];
   int num = 100;
   ArrayResize(open_W1_buf, num);
   ArrayResize(close_W1_buf, num);
   ArrayResize(tm_buf, num);
   ArraySetAsSeries(open_W1_buf, true);
   ArraySetAsSeries(close_W1_buf, true);
   ArraySetAsSeries(tm_buf, true);
   
   int copied = CopyOpen(symbolname, PERIOD_W1, 0, num, open_W1_buf);
   copied = CopyClose(symbolname, PERIOD_W1, 0, num, close_W1_buf);
   
   RefreshRates();
   
   double ma_w1_5,
   ma_w1_30,
   ma_w1_5_pre,
   ma_w1_30_pre;
   
   get_symbol_period_data(symbolname, PERIOD_D1, 5);
   get_symbol_period_data(symbolname, PERIOD_W1, 5);
   
   
   
   //PrintFormat("check_trend %s : %f, %f, %f, %f, %f, %f - %s", symbolname, ma_d1_30, ma_w1_30, ma_mn_30, ma_d1_30_pre, ma_w1_30_pre, ma_mn_30_pre, TimeToStr(tm_buf[0], TIME_DATE|TIME_MINUTES));
   
   
   for ( int i = 0; i < 5; i++ ){
         //ma_w1_5 = iMA( symbolname, PERIOD_W1, 5, 0, MODE_SMA, PRICE_CLOSE, i + 1 );
         //ma_w1_30 = iMA( symbolname, PERIOD_W1, 30, 0, MODE_SMA, PRICE_CLOSE, i + 1 );
         
         ma_w1_5_pre   = iMA( symbolname, PERIOD_W1, 5, 0, MODE_SMA, PRICE_CLOSE, i + 2 );
         ma_w1_30_pre   = iMA( symbolname, PERIOD_W1, 30, 0, MODE_SMA, PRICE_CLOSE, i + 2 );

      if(ma_w1_5_pre < ma_w1_30_pre && open_W1_buf[i+1]<close_W1_buf[i+1] && open_W1_buf[i+2]<close_W1_buf[i+2] && open_W1_buf[i+3]>close_W1_buf[i+3]){
         sign = 1;
         //PrintFormat("%s", symbolname);
      }
   }
   
   
   
   
   
   return sign;
}


int check_data_status(int idx, string symbolname, ENUM_TIMEFRAMES timeframe){
   int sign = 0;
   
   datetime tm_buf[], tm_buf_s[];
   int num = 100, szjs = 0;
   ArrayResize(tm_buf, num);
   ArraySetAsSeries(tm_buf, true);
   ArrayResize(tm_buf_s, num);
   ArraySetAsSeries(tm_buf_s, true);
   
   int copied = CopyTime(symbolname, timeframe, 0, num, tm_buf_s);
   copied = CopyTime(symbolname, PERIOD_M1, 0, num, tm_buf);
   
   int cm = TimeHour(tm_buf[0]) * 10000 + TimeMinute(tm_buf[0]) * 100 + TimeSeconds(tm_buf[0]);
   int sjc = tm_buf_s[0] - tm_buf[0];
   if(chk_fg[idx] != cm){
     chk_fg[idx] = cm; 
     if(sjc == 0){
         //PrintFormat("check_signal %s : %s - %s : %d", symbolname, TimeToStr(tm_buf_s[0], TIME_DATE|TIME_MINUTES), TimeToStr(tm_buf[0], TIME_DATE|TIME_MINUTES), sjc);
         sign = 1;
      }else{
         chk_fg[idx] = -1;
      }
   }
   
   

   
   return sign;
}


int check_signal(string symbolname, ENUM_TIMEFRAMES timeframe, int py){
   int sign = 0;
   int dateIndex = 0 + py;
   
   double close_buf[];
   datetime tm_buf[];
   int num = 100, szjs = 0;
   ArrayResize(tm_buf, num);
   ArraySetAsSeries(tm_buf, true);
   
   int copied = CopyTime(symbolname, timeframe, 0, num, tm_buf);
   copied = CopyClose(symbolname, timeframe, 0, num, close_buf);
   RefreshRates();
   get_symbol_period_data(symbolname, timeframe, 5);
   
   double popen, pclose, close, plow, mamin, mamax,
   k,
   d,
   ma5,
   ma30,
   ma30_p1;
   
   popen = iOpen(symbolname,timeframe,dateIndex + 1);
   pclose = iClose(symbolname,timeframe,dateIndex + 1);
   close = iClose(symbolname,timeframe,dateIndex);
   plow = iLow(symbolname,timeframe,dateIndex + 1);
   k  = iStochastic( symbolname, timeframe, 9, 5, 5, MODE_SMA, 0, MODE_MAIN, dateIndex );
   d  = iStochastic( symbolname, timeframe, 9, 5, 5, MODE_SMA, 0, MODE_SIGNAL, dateIndex );
   ma5   = iMA( symbolname, timeframe, 5, 0, MODE_SMA, PRICE_CLOSE, dateIndex + 1 );
   ma30   = iMA( symbolname, timeframe, 30, 0, MODE_SMA, PRICE_CLOSE, dateIndex + 1);
   
   if(ma5 > ma30){
      mamax = ma5;
      mamin = ma30;
   }else{
      mamax = ma30;
      mamin = ma5;
   }
   
   
   
   
   for ( int i = 0; i < 20; i++ ){
      ma30   = iMA( symbolname, timeframe, 30, 0, MODE_SMA, PRICE_CLOSE, dateIndex + i);
      ma30_p1   = iMA( symbolname, timeframe, 30, 0, MODE_SMA, PRICE_CLOSE, dateIndex + i + 1 );
      if(ma30>ma30_p1){
         szjs = szjs + 1;
      }
   }
   
   if(plow < mamin && pclose > mamax && popen < pclose){
      sign = 1;
   }
   
   if(k < 25 && d < 25 && close>ma5 && szjs >= 7){
      sign = 1;
   }
   
   PrintFormat("check_signal %s : %d - %f, %f, %f, %f, %d - %s", symbolname, sign, close, k, d, ma5, szjs, TimeToStr(tm_buf[dateIndex], TIME_DATE|TIME_MINUTES));
   
   return sign;
}

int get_sign(string symbolname, ENUM_TIMEFRAMES timeframe, int py){
   int         sign = 0;            /* signal array (true - buy, false - sell) */
   
   if(check_signal(symbolname, timeframe, py) == 1){
   //if(((check_manual_follow(symbolname, "L") > 0) || (check_trend_zhuanxiang(symbolname, "L") > 0)) && (check_signal(symbolname, timeframe) == 1)){
   //if(check_trend(symbolname, "L") == true && check_signal(symbolname, timeframe) == 1){
      sign = 1;
   }

   return sign;
}

bool open_manul_list()
{
   int num = SymbolsTotal( false );
   //string symbolList = "Signal List:"
   bool has = false;
   
   int sdindex = 0;
   for ( int i = 1; i <= num; i++ )
   {
      string name = SymbolName( i - 1, false );
      if(check_manual_follow(name, "L") == 1){
         ChartOpen(name, PERIOD_H4);
      }
   }
   
}

bool get_signs(string& symbolList, bool cf, bool oc_flag, int py)
{
   int num = SymbolsTotal( false );
   //string symbolList = "Signal List:"
   bool has = false;
   
   int sdindex = 0;
   for ( int i = 1; i <= num; i++ )
   {
      string name = SymbolName( i - 1, false );
      //if(StringFind(name, "pro", 6) > 0){
      //   continue;
      //}

      /*
      get_sign(name, PERIOD_M1, sds[sdindex++]);
      get_sign(name, PERIOD_M5, sds[sdindex++]);
      get_sign(name, PERIOD_M15, sds[sdindex++]);
      
      get_sign(name, PERIOD_M30, sds[sdindex++]);
      get_sign(name, PERIOD_H1, sds[sdindex++]);
      */
      int status = check_data_status(i, name, PERIOD_H4);
      //Print("Signal  " + name + ":" + IntegerToString(sign));
      if(cf || status == 1){
         if(check_in_trend_list(name) == 1){
            int sign = get_sign(name, PERIOD_H4, py);
            //Print("Signal  " + name + ":" + IntegerToString(sign));
            if(sign == 1){
               if(oc_flag == 1){
                  long cid = ChartOpen(name, PERIOD_H4);
                  ChartApplyTemplate(cid, "\\Files\May.tpl");
               }
               symbolList = symbolList + name + " / ";
               has = true;
            }
         }
      }
      
      
      
      //get_sign(name, PERIOD_D1);
      
      //get_sign(name, PERIOD_W1, sds[sdindex++]);
      //get_sign(name, PERIOD_MN1, sds[sdindex++]);
   }
   
   return has;
}


int check_in_trend_list(string symbol){
   int inf = 0;
   for(int i = 0; i < idx; i++){
      if(trend_list[i] == symbol){
         inf = 1;
         break;
      }
   }
   return inf;
}



void open_charts(int period)
{
   int num = SymbolsTotal( false );
   //string symbolList = "Signal List:"
   bool has = false;
   
   int sdindex = 0;
   for ( int i = 1; i <= num; i++ )
   {
      string name = SymbolName( i - 1, false );
      ChartOpen(name, period);
   }
}


  
//+------------------------------------------------------------------+

