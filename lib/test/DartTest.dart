void main() {
  String s = r'''去   <--我-->   额   <--他\r-->\n
  
     有\r  <--哦\n-->  啊 ''';

 final f= s.split(RegExp(r'<--([\S\s]*?)-->'));
  String ss = s.replaceAll(RegExp(r'<--([\S\s]*?)-->'), '');
  print(f);
}
