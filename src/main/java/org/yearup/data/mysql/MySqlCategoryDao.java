package org.yearup.data.mysql;

import org.springframework.jca.cci.connection.ConnectionSpecConnectionFactoryAdapter;
import org.springframework.security.access.method.P;
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
    public List<Category> getAllCategories() // get help with this one
    {
        // get all categories
        return null;
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
        String sql = "INSERT INTO categories(category_id, name, description" +
                     "VALUES (?, ?, ?);";

        try (Connection connection = getConnection()) {
            PreparedStatement prepState = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            prepState.setInt(1,category.getCategoryId());
            prepState.setString(2, category.getName());
            prepState.setString(3, category.getDescription());

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
    public void update(int categoryId, Category category)
    {
        // update category
    }

    @Override
    public void delete(int categoryId)
    {
        // delete category
    }

    private Category mapRow(ResultSet row) throws SQLException
    {
        int categoryId = row.getInt("category_id");
        String name = row.getString("name");
        String description = row.getString("description");

        Category category = new Category()
        {{
            setCategoryId(categoryId);
            setName(name);
            setDescription(description);
        }};

        return category;
    }

}
