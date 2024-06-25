package org.yearup.data.mysql;


import org.springframework.stereotype.Component;
import org.yearup.data.CategoryDao;
import org.yearup.models.Category;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Component
public class MySqlCategoryDao extends MySqlDaoBase implements CategoryDao
{
    public MySqlCategoryDao(DataSource dataSource)
    {
        super(dataSource);
    }

    @Override
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM Categories";

        try (Connection connection = getConnection();
             PreparedStatement prepState = connection.prepareStatement(sql);
             ResultSet results = prepState.executeQuery()) {
            while(results.next()) {
                int categoryId = results.getInt("category_id");
                String categoryName = results.getString("name");
                String description = results.getString("description");
                categories.add(new Category(categoryId, categoryName, description));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    @Override
    public Category getById(int categoryId) {

        String sql = "SELECT * FROM categories " +
                     "WHERE category_id = ?";

        try(Connection connection = getConnection()) {
            PreparedStatement prepState = connection.prepareStatement(sql);
            prepState.setInt(1, categoryId);

            ResultSet results = prepState.executeQuery();
            if (results.next()) {
                return mapRow(results);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public Category create(Category category) {
        String sql = "INSERT INTO categories(name, description) " +
                     " VALUES (?, ?);";

        try (Connection connection = getConnection()) {
            PreparedStatement prepState = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            prepState.setString(1, category.getName());
            prepState.setString(2, category.getDescription());

            int newRows = prepState.executeUpdate();

            if(newRows > 0) {
                ResultSet genKeys = prepState.getGeneratedKeys();

                if(genKeys.next()) {
                    int orderId = genKeys.getInt(1);
                    return getById(orderId);
                }
            }
        }

        catch(SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public void update(int categoryId, Category category) {
        String sql = "UPDATE categories " +
                     "SET name = ? " +
                     ", description = ? " +
                     "WHERE category_id = ?";

        try (Connection connection = getConnection()) {
            PreparedStatement presState = connection.prepareStatement(sql);
            presState.setString(1, category.getName());
            presState.setString(2, category.getDescription());
            presState.setInt(3, categoryId);

            presState.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void delete(int categoryId) {

        String sql = "DELETE FROM categories " +
                     "WHERE category_id = ?;";

        try(Connection connection = getConnection()) {
            PreparedStatement prepState = connection.prepareStatement(sql);
            prepState.setInt(1, categoryId);

            prepState.executeUpdate();
        }  catch (SQLException e) {

            throw new RuntimeException(e);
        }
    }

    private Category mapRow(ResultSet row) throws SQLException
    {
        int id = row.getInt("category_id");
        String name = row.getString("name");
        String description = row.getString("description");

        Category category = new Category()
        {{
            setCategoryId(id);
            setName(name);
            setDescription(description);
        }};

        return category;
    }

}
