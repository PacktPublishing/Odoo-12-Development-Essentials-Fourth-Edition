## Modifying an existing model to add a field

### Adding a field to a Model

  - Menu: `Settings | Technical | Database Structure | Models`
  - Search `res.partner`, click `Edit`
  - Add Field:
    - Field Name:  `x_is_work_team`
    - Field Label: `Is Work Team?`
    - Field Type:  `boolean`

### Adding a field to a form view

  - Menu Contacts --> Form View --> Debug menu | Edit Form View
  - "Inherited Views" tab --> Add an Item --> Create:
    - View Name: Contacts - Custom "Is Work Team" flag
    - Architecture:
      ```
      <field name="category_id" position="after">
          <field name="x_is_work_team" />
      </field>
      ```

## Creating a new Model

Menu: `Settings | Technical | Database Structure | Models`, click `Create`:

   - Model Description: `To-do Item`
   - Model: `x_todo_item`
   - Fields, click `Add an Item`:
     - Field Name:      `x_is_done`
     - Field Label:     `Is Done?`
     - Field Type:      `boolean`
   - Fields, click `Add an Item`:
     - Field Name:      `x_work_team_ids`
     - Field Label:     `Work Team`
     - Field Type:      `many2many`
     - Object Relation: `res.partner`
     - Domain:          `[('x_is_work_team', '=', True)]`


## Configuring access control security

### Security Groups

Menu: `Settings | Users & Companies | Groups`, click `Create`:

   - Application: Leave empty
   - Name: `To-do User`
   - Inherited tab: add `User types / Internal User`
   - Access Rights tab: click `Add an Item`
     - Object: select `To-do Item` from the list
     - Read, Write, Create and Delete Access: Checked
     - Name: `To-do Item User Access`

### Security Record Rules

Menu: `Settings | Technical | Security | Record Rules`, click `Create`:

   - Name: `To-do Own Items`
   - Object: select `To-do Item`
   - Access Rights: leave all checked.
   - Rule Definition: `[('create_uid', '=', user.id)]` 
   - Groups: select `To-do / User`


## Creating Menu Items

1. Menu: `Settings | Technical | User Interface | Menu Items`, click `Create`
   - Menu: `To-do`
   - Parent Menu: (empty)
   - Action: `ir.actions.act_window`, click `Create and Edit` --> `Window Action`:
     - Action name: `To-do Items`
     - Object: `x_todo_item`


## Create Views

1. Create List View
   - Menu: `Settings | Technical | User Interface | Views`, click  `Create`
     - View Name: `To-do List View`
     - View Type: `Tree`
     - Model: `x_todo_item`
     - Architecture:
     ```
     <tree>
       <field name="x_name" />
       <field name="x_is_done" />
     </tree>
     ``` 
2. Create Form View
   - Menu: `Settings | Technical | User Interface | Views`, click `Create`
     - View Name: `To-do Form View`
     - View Type: `Form`
     - Model: `x_todo_item`
     - Architecture:
     ```
     <form>
       <group>
         <field name="x_name" />
         <field name="x_is_done" />
         <field name="x_work_team_ids" 
                widget="many2many_tags" 
                context="{'default_x_is_work_team': True}" />
       </group>
     </form>
     ``` 

3. Create Search View
   - Menu: `Settings | Technical | User Interface | Views`, click `Create`
     - View Name: `To-do Items Filter`
     - View Type: `Search`
     - Model: `x_todo_item`
     - Architecture:
     ```
     <search>
       <filter name="item_not_done" 
               string="Not Done" 
               domain="[('x_is_done', '=', False)]" />
     </search>
     ```

4. Enable a Search option on a Menu Action

    - Click on the To-do menu option to go to the To-do list.
    - Click on the Developer Tools icon and select the Edit Action option.
    - In the lower-right corner, Filter section:
        - Set "Context" to: {'search_default_item_not_done': True}
