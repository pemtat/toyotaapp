String stringToStatus(String status) {
  switch (status) {
    case '10':
      return 'new';
    case '20':
      return 'feedback';
    case '30':
      return "acknowledged";
    case '40':
      return 'confirmed';
    case '50':
      return 'assigned';
    case '80':
      return 'resolved';
    case '90':
      return 'closed';
    default:
      return 'new';
  }
}
