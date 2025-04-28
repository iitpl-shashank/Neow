class CycleDates{
    DateTime _date = DateTime.now();
    bool _isPeriod=false;
    bool _isOvulation=false;
    bool _isFertile=false;
    int _periodDay=1;

    CycleDates(DateTime? date,bool? isPeriod, bool? isOvulation, bool? isFertile, int? periodDay)
    {
        if(date!=null){
            _date = date;
        }
        if(isPeriod!=null){
            _isPeriod = isPeriod;
        }
        if(isOvulation!=null){
            _isOvulation = isOvulation;
        }
        if(isFertile!=null){
            _isFertile = isFertile;
        }
        if(periodDay!=null){
            _periodDay = periodDay;
        }
        
    }

    DateTime get date=>_date;
    set date(DateTime date)=>_date = date;

    bool get isPeriod=>_isPeriod;
    set isPeriod(bool isPeriod)=>_isPeriod = isPeriod;

    bool get isOvulation=>_isOvulation;
    set isOvulation(bool isOvulation)=>_isOvulation = isOvulation;

    bool get isFertile=>_isFertile;
    set isFertile(bool isFertile)=>_isFertile = isFertile;

    int get periodDay=>_periodDay;
    set periodDay(int periodDay)=>_periodDay = periodDay;

}