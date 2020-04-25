/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm
{
  String   _ingredient;
  String   _calories;
  String   _totalFat;
  String   _sFat;
  String   _tFat;
  String   _cholesterol;
  String   _sodium;
  String   _tCarbo;
  String   _tSugar;
  String   _aSugar;

  FeedbackForm(this._ingredient, this._calories, this._totalFat, this._sFat, this._tFat, this._cholesterol, this._sodium
      , this._tCarbo, this._tSugar, this._aSugar);

  // Method to make GET parameters.
  String toParams() =>
      "?ingredient=$_ingredient&calories=$_calories&totalFat=$_totalFat&sFat=$_sFat&tFat=$_tFat&cholesterol=$_cholesterol&sodium=$_sodium&tCarbo=$_tCarbo&tSugar=$_tSugar&aSugar=$_aSugar";
}