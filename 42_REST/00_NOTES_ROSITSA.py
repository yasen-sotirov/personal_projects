"REST"   # архитектура и принципи която се базира на някакви принципи

"""

не е задължителна
съдържа правила и ограничения
прави комуникацията между клиент и сървър
универсален език, на който могат да си говорят всякакви видове устройства, програмни езици
имплементира се бързо,  


Други видове архитектури - XML, HTML

REST се имплементира с HTTP (общ създател)



Representation - представя инфото под някакъв формат .json
не получаваме ресурса като питонски файл, а като универсален json формат

сървъра прави сереализация на питонския код, така го преобразува в json файл
десереализация - обратния процес - от файла към кода

State - състояние на ресурса

status code - информация за това как е протекла заявката




ПРИНЦИПИ НА REST
    Stateless - не е задължително, може и да не е приложимо. Прави сървърите независими
        всяка заявка е независима. Съдържа цялата инфор за това какво искаме. 
        Сървъра не помни заявките, сесиите се запазват при клиента

    Uniform access - еднаквост на представените ресурси. Комуникацията е стандартизирана.
    
    Resource representation - как се репрезентират данните от сървъра и от клиента. 
        Ползва се формат с който лесно се сереализира и десереализира.
        Най често се ползва JSON HTML защото лесно се ползват и четат.


SP Framework - single page - сайт от една страница


WEB SERVICES - REST APIs

Ресурси - всичко което може да бъде съхранено на компютър. 


разлики между REST И HTTP ?

РЕСТ - МОЖЕ ДА ГО ПОЛЗВАМЕ НО НЕ Е ЗАДЪЛЖИТЕЛНО
URI i URL - qy=esto съвпадат

статус кодове - идват от HTTP и рест ги ползва

круд методи - GET, DELETE, PUT ...






Демото:














"""