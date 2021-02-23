package bll;

import dao.CityDAO;
import dao.FlightDAO;
import model.City;
import model.Flight;
import org.hibernate.cfg.Configuration;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

public class FlightBLL {

    public HashMap<Flight, List<City>> getFlightMap(){
        FlightDAO flightDAO = new FlightDAO(new Configuration().configure().buildSessionFactory());
        CityDAO cityDAO = new CityDAO(new Configuration().configure().buildSessionFactory());
        List<Flight> flightList = flightDAO.findFlights().stream()
                .sorted(Comparator.comparing(Flight::getId))
                .collect(Collectors.toList());
        HashMap<Flight, List<City>> flights = new HashMap<Flight, List<City>>();
        for(Flight f: flightList) {
            List<City> cityList = new ArrayList<City>();
            cityList.add(cityDAO.findCity(f.getDepartureCityId()));
            cityList.add(cityDAO.findCity(f.getArrivalCityId()));
            flights.put(f, cityList);
        }
        return flights;
    }

    public List<City> getCityList() {
        CityDAO cityDAO = new CityDAO(new Configuration().configure().buildSessionFactory());
        return cityDAO.findCitys();
    }

}
