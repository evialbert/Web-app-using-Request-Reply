package dao;

import model.City;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class CityDAO {

    private static final Log LOGGER = LogFactory.getLog(CityDAO.class);

    private SessionFactory factory;

    public CityDAO(SessionFactory factory) {
        this.factory = factory;
    }

    public City addCity(City city) {
        int cityId = -1;
        Session session = factory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            cityId = (Integer) session.save(city);
            city.setId(cityId);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            LOGGER.error("", e);
        } finally {
            session.close();
        }
        return city;
    }

    @SuppressWarnings("unchecked")
    public List<City> findCitys() {
        Session session = factory.openSession();
        Transaction tx = null;
        List<City> citys = null;
        try {
            tx = session.beginTransaction();
            citys = session.createQuery("FROM City").list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            LOGGER.error("", e);
        } finally {
            session.close();
        }
        return citys;
    }

    @SuppressWarnings("unchecked")
    public City findCity(int id) {
        Session session = factory.openSession();
        Transaction tx = null;
        List<City> citys = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery("FROM City WHERE id = :id");
            query.setParameter("id", id);
            citys = query.list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            LOGGER.error("", e);
        } finally {
            session.close();
        }
        return citys != null && !citys.isEmpty() ? citys.get(0) : null;
    }

    public City deleteCity (int id) {
        Session session = factory.openSession();
        Transaction tx = null;
        City city = null;
        try {
            tx = session.beginTransaction();
            city = findCity(id);
            session.delete(city);
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            LOGGER.error("", e);
        } finally {
            session.close();
        }
        return city;
    }

    public City findCityByName(String name) {
        Session session = factory.openSession();
        Transaction tx = null;
        List<City> citys = null;
        try {
            tx = session.beginTransaction();
            Query query = session.createQuery("FROM City WHERE name = :name");
            query.setParameter("name", name);
            citys = query.list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            LOGGER.error("", e);
        } finally {
            session.close();
        }
        return citys != null && !citys.isEmpty() ? citys.get(0) : null;
    }

}